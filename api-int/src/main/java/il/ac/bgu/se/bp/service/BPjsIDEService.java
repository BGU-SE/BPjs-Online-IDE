package il.ac.bgu.se.bp.service;

import il.ac.bgu.se.bp.rest.request.*;
import il.ac.bgu.se.bp.rest.response.BooleanResponse;
import il.ac.bgu.se.bp.rest.response.DebugResponse;
import il.ac.bgu.se.bp.rest.response.EventsHistoryResponse;

public interface BPjsIDEService {

    void subscribeUser(String sessionId, String userId);

    BooleanResponse run(RunRequest runRequest, String userId);
    DebugResponse debug(DebugRequest debugRequest, String userId);

    BooleanResponse setBreakpoint(String userId, SetBreakpointRequest setBreakpointRequest);
    BooleanResponse toggleMuteBreakpoints(String userId, ToggleBreakpointsRequest toggleBreakPointStatus);
    BooleanResponse toggleWaitForExternal(String userId, ToggleWaitForExternalRequest toggleWaitForExternalRequest);
    BooleanResponse toggleMuteSyncPoints(String userId, ToggleSyncStatesRequest toggleMuteSyncPoints);

    BooleanResponse stop(String userId);
    BooleanResponse stepOut(String userId);
    BooleanResponse stepInto(String userId);
    BooleanResponse stepOver(String userId);
    BooleanResponse continueRun(String userId);

    BooleanResponse nextSync(String userId);

    BooleanResponse externalEvent(String userId, ExternalEventRequest externalEventRequest);
    BooleanResponse setSyncSnapshot(String userId, SetSyncSnapshotRequest setSyncSnapshotRequest);

    EventsHistoryResponse getEventsHistory(String userId, int from, int to);
}
