package il.ac.bgu.se.bp.mocks.testService;

import il.ac.bgu.se.bp.mocks.session.ITSessionManagerImpl;
import il.ac.bgu.se.bp.mocks.session.ITStompSessionHandler;
import il.ac.bgu.se.bp.rest.request.*;
import il.ac.bgu.se.bp.rest.response.BooleanResponse;
import il.ac.bgu.se.bp.rest.response.DebugResponse;
import il.ac.bgu.se.bp.rest.utils.Endpoints;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.http.Header;
import io.restassured.response.Response;
import org.springframework.messaging.converter.MappingJackson2MessageConverter;
import org.springframework.web.socket.client.WebSocketClient;
import org.springframework.web.socket.client.standard.StandardWebSocketClient;
import org.springframework.web.socket.messaging.WebSocketStompClient;

import java.security.Principal;
import java.util.concurrent.ConcurrentHashMap;

import static il.ac.bgu.se.bp.common.Utils.waitUntilPredicateSatisfied;
import static il.ac.bgu.se.bp.rest.utils.Endpoints.*;

public class RestServiceTestHelper implements TestService {

    private static final String BASE_URI = "localhost:8080";
    private static final String BASE_REST_URI = "http://" + BASE_URI + Endpoints.BASE_URI;
    private static final String SOCKET_URI = "ws://" + BASE_URI + "/ws";
    private static final String USER_ID = "userId";

    private final ITSessionManagerImpl usersSessionHandler;

    private static final ConcurrentHashMap<String, String> userTestIdsToServerIds = new ConcurrentHashMap<>();
    private static final ConcurrentHashMap<String, ITStompSessionHandler> userSessionsByTestIds = new ConcurrentHashMap<>();

    public RestServiceTestHelper(ITSessionManagerImpl sessionHandler) {
        this.usersSessionHandler = sessionHandler;
    }

    private String getSocketUserId(String userTestId) {
        return userTestIdsToServerIds.get(userTestId);
    }

    @Override
    public void subscribeUser(String sessionId, Principal principal) {
        WebSocketClient client = new StandardWebSocketClient();
        WebSocketStompClient stompClient = new WebSocketStompClient(client);
        stompClient.setMessageConverter(new MappingJackson2MessageConverter());

        ITStompSessionHandler sessionHandler = new ITStompSessionHandler(usersSessionHandler);
        sessionHandler.setTestUserId(principal.getName());
        stompClient.connect(SOCKET_URI, sessionHandler);

        waitUntilPredicateSatisfied(sessionHandler::isConnected, 500, 3);
        userTestIdsToServerIds.put(principal.getName(), sessionHandler.getServerUserId());
        userSessionsByTestIds.put(principal.getName(), sessionHandler);
    }

    @Override
    public BooleanResponse run(String userId, RunRequest runRequest) {
        return performPostRequest(userId, RUN, runRequest);
    }

    @Override
    public DebugResponse debug(String userId, DebugRequest debugRequest) {
        Response response = RestAssured.with().header(new Header(USER_ID, getSocketUserId(userId))).body(debugRequest)
                .contentType(ContentType.JSON).when().post(BASE_REST_URI + DEBUG);
        response.then().statusCode(200);
        return response.getBody().as(DebugResponse.class);
    }

    @Override
    public BooleanResponse setBreakpoint(String userId, SetBreakpointRequest setBreakpointRequest) {
        return performPostRequest(userId, BREAKPOINT, setBreakpointRequest);
    }

    @Override
    public BooleanResponse toggleMuteBreakpoints(String userId, ToggleBreakpointsRequest toggleBreakpointsRequest) {
        return performPutRequest(userId, BREAKPOINT, toggleBreakpointsRequest);
    }

    @Override
    public BooleanResponse toggleMuteSyncPoints(String userId, ToggleSyncStatesRequest toggleMuteSyncPoints) {
        return performPutRequest(userId, SYNC_STATES, toggleMuteSyncPoints);
    }

    @Override
    public BooleanResponse toggleWaitForExternal(String userId, ToggleWaitForExternalRequest toggleWaitForExternalRequest) {
        return performPutRequest(userId, WAIT_EXTERNAL, toggleWaitForExternalRequest);
    }

    @Override
    public BooleanResponse stop(String userId) {
        return performGetRequest(userId, STOP);
    }

    @Override
    public BooleanResponse stepOut(String userId) {
        return performGetRequest(userId, STEP_OUT);
    }

    @Override
    public BooleanResponse stepInto(String userId) {
        return performGetRequest(userId, STEP_INTO);
    }

    @Override
    public BooleanResponse stepOver(String userId) {
        return performGetRequest(userId, STEP_OVER);
    }

    @Override
    public BooleanResponse continueRun(String userId) {
        return performGetRequest(userId, CONTINUE);
    }

    @Override
    public BooleanResponse nextSync(String userId) {
        return performGetRequest(userId, NEXT_SYNC);
    }

    @Override
    public BooleanResponse externalEvent(String userId, ExternalEventRequest externalEventRequest) {
        return performPostRequest(userId, EXTERNAL_EVENT, externalEventRequest);
    }

    @Override
    public BooleanResponse setSyncSnapshot(String userId, SetSyncSnapshotRequest setSyncSnapshotRequest) {
        return performPostRequest(userId, SYNC_SNAPSHOT, setSyncSnapshotRequest);
    }

    private BooleanResponse performPostRequest(String userId, String URL, Object body) {
        Response response = RestAssured.with().header(new Header(USER_ID, getSocketUserId(userId))).body(body)
                .contentType(ContentType.JSON).when().post(BASE_REST_URI + URL);
        response.then().statusCode(200);
        return response.getBody().as(BooleanResponse.class);
    }

    private BooleanResponse performPutRequest(String userId, String URL, Object body) {
        Response response = RestAssured.with().header(new Header(USER_ID, getSocketUserId(userId))).body(body)
                .contentType(ContentType.JSON).when().put(BASE_REST_URI + URL);
        response.then().statusCode(200);
        return response.getBody().as(BooleanResponse.class);
    }

    private BooleanResponse performGetRequest(String userId, String URL) {
        Response response = RestAssured.with().header(new Header(USER_ID, getSocketUserId(userId)))
                .contentType(ContentType.JSON).when().get(BASE_REST_URI + URL);
        response.then().statusCode(200);
        return response.getBody().as(BooleanResponse.class);
    }
}
