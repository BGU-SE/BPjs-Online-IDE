#Feature: Sync States
#  Scenario: four users request to debug with multiple sync states stops
#  Given user alex has connected with userId 4655ae8e-cdfe-4ce3-ac2b-dc03743a780f
##  And user tal has connected with userId d1b10451-bbb0-43e2-b5ad-d10afa73449e
##  And user avishai has connected with userId 23c125e3-2ab1-4111-ad4a-0a5de594ae26
##  And user ron has connected with userId fddc28aa-e203-40c0-989d-276e0eabf04c
#
#  Given alex has connected to websocket with alex-session
##  And ron has connected to websocket with ron-session
#
#  When alex asks to debug with filename testFile1 and toggleMuteBreakpoints true and toggleMuteSyncPoints false and breakpoints 10,21
#  Then The debug response should be true with errorCode null and breakpoints 10,21 for user alex
##  When ron asks to debug with filename testFile2 and toggleMuteBreakpoints true and toggleMuteSyncPoints false and breakpoints 4,9,11
##  Then The debug response should be true with errorCode null and breakpoints 4,9,11 for user ron
#
#  Then wait until user alex has reached sync state
##  And wait until user ron has reached sync state
#
#  Then alex should get sync state notification wait events [blank], blocked events [blank], requested events son-e, current event [blank], and b-threads info list {name:bt-world-son,requested:[son-e]}
##  And ron should get sync state notification wait events [blank], blocked events [blank], requested events [Thread1-EVENT,Thread2-EVENT], current event [blank], and b-threads info list {name:Thread1,requested:[Thread1-EVENT]}{name:Thread2,requested:[Thread2-EVENT]}
#
##  Given avishai has connected to websocket with avishai-session
##  And tal has connected to websocket with tal-session
##
##  When avishai asks to debug with filename testFile1 and toggleMuteBreakpoints true and toggleMuteSyncPoints false and breakpoints 10,21
##  Then The debug response should be true with errorCode null and breakpoints 10,21 for user avishai
##  When tal asks to debug with filename testFile2 and toggleMuteBreakpoints true and toggleMuteSyncPoints false and breakpoints 4,9,11
##  Then The debug response should be true with errorCode null and breakpoints 4,9,11 for user tal
#
##  And wait until user avishai has reached sync state
##  And wait until user tal has reached sync state
##
##  Then avishai should get sync state notification wait events [blank], blocked events [blank], requested events son-e, current event [blank], and b-threads info list {name:bt-world-son,requested:[son-e]}
##  And tal should get sync state notification wait events [blank], blocked events [blank], requested events [Thread1-EVENT,Thread2-EVENT], current event [blank], and b-threads info list {name:Thread1,requested:[Thread1-EVENT]}{name:Thread2,requested:[Thread2-EVENT]}
#
#  When alex toggles mute sync states to true
#  Then The response should be true with errorCode null
##  When tal toggles mute sync states to true
##  Then The response should be true with errorCode null
#
#  When alex clicks on next sync
#  Then The response should be true with errorCode null
##  When tal clicks on next sync
##  Then The response should be true with errorCode null
##  When avishai clicks on next sync
##  Then The response should be true with errorCode null
##  When ron clicks on next sync
##  Then The response should be true with errorCode null
#
#  Then wait until program of user alex is over
##  And wait until program of user tal is over
##  And wait until user avishai has reached sync state
##  And wait until user ron has reached sync state
#
###  Then avishai should get sync state notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
###  And ron should get sync state notification with BThread {4:Thread1}{9:Thread2}{11:Thread2}, doubles {4:t=6.0}{9:varT2B=1}{11:varT2B=1}, strings {11:var2=alex} and breakpoint lines 4,9,11
#
##  When avishai clicks on next sync
##  Then The response should be true with errorCode null
##  When ron clicks on next sync
##  Then The response should be true with errorCode null
##
##  Then wait until user avishai has reached sync state
##  And wait until user ron has reached sync state
#
##  Then avishai should get sync state notification with BThread {10:bt-world-son}{21:bt-world,bt-world-son}, doubles {10:x=5.0,y=16.7}{21:m=50,n=100,p=150}, strings {10:z=alex} and breakpoint lines 10,21
##  And verify all breakpoints of user avishai were reached
#
##  Then ron should get sync state notification with BThread {4:Thread1}{9:Thread2}{11:Thread2}, doubles {4:t=6.0}{9:varT2B=1}{11:varT2B=1}, strings {11:var2=alex} and breakpoint lines 4,9,11
##  And verify all breakpoints of user ron were reached