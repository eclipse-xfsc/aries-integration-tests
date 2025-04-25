Feature: Offer membership credentials
         Offer the membership credentials to the holder when the connection is in complete state 

Scenario: Process connection request when status is complete   
Given the connection status as complete
# Controller.ts -> connectionComplete
When I evaluate status as complete
# Nats -> 'ATTESTATION_MANAGER_SERVICE/offerMemberShipCredentials'
Then I called the offer membership credentials (attestation service)
And get a successful response
Then sends the response with message status connection received

Scenario: Process connection request when status is other than complete
Given the connection status other than complete
# Controller.ts -> connectionComplete
When I evaluate status as not complete
Then sends the response with message connection status should be Complete
