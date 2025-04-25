As an OCM user
    I want to offer MemberShip Credentials

@IDM.OCM.E1.00015
Feature: Offer a membership credential to User

    Scenario: Provide valid and required status, connectionId, theirLabel and participantDid
        Given AFJ Agent NATS Publisher have passed all required offer membership credential details.
        # src\issue-credential\controller\controller.ts -> NATS call for topic 'ATTESTATION_MANAGER_SERVICE/offerMemberShipCredentials'
        When passed all valid offer membership credential details.
        Then credential offer should be sent to the given connection.
        And I should get the HTTP status code 201 Created and the created membership credential offer Details.
