Feature: Breakpoints
  Scenario Outline: multiple valid breakpoints
    Given user <username> has connected with userId <userId>
    And <username> has connected to websocket with <sessionId>
    When <username> asks to debug with filename <filename> and toggleMuteBreakpoints <toggleMuteBreakpoints> and toggleMuteSyncPoints <toggleMuteSyncPoints> and breakpoints <breakpoints>
    Then The response should be true with errorCode null
    And wait until user <username> has reached breakpoint
    And <username> should get notification with BThread <bThreadNameByBreakpoint>, doubles <doubleVariables>, strings <stringVariables> and breakpoint lines <breakpoints>
    When <username> clicks on continue
    Then The response should be true with errorCode null
    And wait until user <username> has reached breakpoint
    And <username> should get notification with BThread <bThreadNameByBreakpoint>, doubles <doubleVariables>, strings <stringVariables> and breakpoint lines <breakpoints>
    When <username> clicks on continue
    Then The response should be true with errorCode null
    And wait until user <username> has reached breakpoint
    And <username> should get notification with BThread <bThreadNameByBreakpoint>, doubles <doubleVariables>, strings <stringVariables> and breakpoint lines <breakpoints>
    And verify all breakpoints of user <username> were reached

    Examples:
      | username | sessionId  | userId                               | filename  | toggleMuteBreakpoints | toggleMuteSyncPoints | bThreadNameByBreakpoint                     | breakpoints | stringVariables | doubleVariables                                                           |
      | alex     | sessionId1 | 4655ae8e-cdfe-4ce3-ac2b-dc03743a780f | testFile1 | false                 | true                 | {10:bt-world-son}{21:bt-world,bt-world-son} | 10,21       | {10:z=alex}     | {10:x=5.0,y=16.7}{21:m=50,n=100,p=150} |
      | tal      | sessionId2 | d1b10451-bbb0-43e2-b5ad-d10afa73449e | testFile2 | false                 | true                 | {4:Thread1}{9:Thread2}{11:Thread2}          | 4,9,12      | {11:var2=alex}  | {4:t=6.0}{9:varT2B=1}{11:varT2B=1}     |

  Scenario Outline: toggle mute breakpoints after first breakpoint
    Given user <username> has connected with userId <userId>
    And <username> has connected to websocket with <sessionId>
    When <username> asks to debug with filename <filename> and toggleMuteBreakpoints <toggleMuteBreakpoints> and toggleMuteSyncPoints <toggleMuteSyncPoints> and breakpoints <breakpoints>
    Then The response should be true with errorCode null
    And wait until user <username> has reached breakpoint
    And <username> should get notification with BThread <bThreadNameByBreakpoint>, doubles <doubleVariables>, strings <stringVariables> and breakpoint lines <breakpoints>
    When <username> toggles mute breakpoints to true
    Then The response should be true with errorCode null
    When <username> clicks on continue
    Then The response should be true with errorCode null
    And wait until program of user <username> is over
    And verify user <username> has reached only 1 breakpoints

    Examples:
      | username | sessionId  | userId                               | filename  | toggleMuteBreakpoints | toggleMuteSyncPoints | bThreadNameByBreakpoint                     | breakpoints | stringVariables | doubleVariables                                                           |
      | alex     | sessionId1 | 4655ae8e-cdfe-4ce3-ac2b-dc03743a780f | testFile1 | false                 | true                 | {10:bt-world-son}{21:bt-world,bt-world-son} | 10,21       | {10:z=alex}     | {10:x=5.0,y=16.7}{21:m=50,n=100,p=150} |
      | tal      | sessionId2 | d1b10451-bbb0-43e2-b5ad-d10afa73449e | testFile2 | false                 | true                 | {4:Thread1}{9:Thread2}{11:Thread2}          | 4,9,11      | {11:var2=alex}  | {4:t=6.0}{9:varT2B=1}{11:varT2B=1}     |

#  Scenario: four users request to debug with multiple breakpoints
#    Given user alex has connected with userId 4655ae8e-cdfe-4ce3-ac2b-dc03743a780f
#    And user tal has connected with userId d1b10451-bbb0-43e2-b5ad-d10afa73449e
#    And user avishai has connected with userId 23c125e3-2ab1-4111-ad4a-0a5de594ae26
#    And user ron has connected with userId fddc28aa-e203-40c0-989d-276e0eabf04c
#
#    Given alex has connected to websocket with alex-session
#    And tal has connected to websocket with tal-session
#    And avishai has connected to websocket with avishai-session
#    And ron has connected to websocket with ron-session
#
#    When alex asks to debug with filename testFile1 and toggleMuteBreakpoints false and toggleMuteSyncPoints true and breakpoints 10,21
#    Then The response should be true with errorCode null
#    When tal asks to debug with filename testFile1 and toggleMuteBreakpoints false and toggleMuteSyncPoints true and breakpoints 10,21
##    When tal asks to debug with filename testFile2 and toggleMuteBreakpoints false and toggleMuteSyncPoints true and breakpoints 4,9,11
#    Then The response should be true with errorCode null
#    When avishai asks to debug with filename testFile1 and toggleMuteBreakpoints false and toggleMuteSyncPoints true and breakpoints 10,21
#    Then The response should be true with errorCode null
#    When ron asks to debug with filename testFile1 and toggleMuteBreakpoints false and toggleMuteSyncPoints true and breakpoints 10,21
##    When ron asks to debug with filename testFile2 and toggleMuteBreakpoints false and toggleMuteSyncPoints true and breakpoints 4,9,11
#    Then The response should be true with errorCode null
#
#    Then wait until user alex has reached breakpoint
#    And wait until user tal has reached breakpoint
#    And wait until user avishai has reached breakpoint
#    And wait until user ron has reached breakpoint
#
#    Then alex should get notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
#    Then tal should get notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
##    And tal should get notification with BThread {4:Thread1}{9:Thread2}{11:Thread2}, doubles {4:t=6.0}{9:varT2B=1}{11:varT2B=1}, strings {11:var2=alex} and breakpoint lines 4,9,11
#    And avishai should get notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
#    Then ron should get notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
##    And ron should get notification with BThread {4:Thread1}{9:Thread2}{11:Thread2}, doubles {4:t=6.0}{9:varT2B=1}{11:varT2B=1}, strings {11:var2=alex} and breakpoint lines 4,9,11
#
#    When alex toggles mute breakpoints to true
#    And tal toggles mute breakpoints to true
#
#    When alex clicks on continue
#    Then The response should be true with errorCode null
#    When tal clicks on continue
#    Then The response should be true with errorCode null
#    When avishai clicks on continue
#    Then The response should be true with errorCode null
#    When ron clicks on continue
#    Then The response should be true with errorCode null
#
#    Then wait until program of user alex is over
#    And verify user alex has reached only 1 breakpoints
#    And wait until program of user alex is over
#    And verify user tal has reached only 1 breakpoints
#
#    Then avishai should get notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
#    Then ron should get notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
##    And ron should get notification with BThread {4:Thread1}{9:Thread2}{11:Thread2}, doubles {4:t=6.0}{9:varT2B=1}{11:varT2B=1}, strings {11:var2=alex} and breakpoint lines 4,9,11
#
#    When avishai clicks on continue
#    Then The response should be true with errorCode null
#    When ron clicks on continue
#    Then The response should be true with errorCode null
#
#    Then wait until user avishai has reached breakpoint
#    And wait until user ron has reached breakpoint
#
#    Then avishai should get notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
#    And verify all breakpoints of user should were reached
#
#    Then ron should get notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
##    Then ron should get notification with BThread {4:Thread1}{9:Thread2}{11:Thread2}, doubles {4:t=6.0}{9:varT2B=1}{11:varT2B=1}, strings {11:var2=alex} and breakpoint lines 4,9,11
#    And verify all breakpoints of user should were reached
