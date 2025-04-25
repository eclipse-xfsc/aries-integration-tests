As an OCM user
    I want to get the credentials issued to a given connection

@IDM.OCM.E1.00015
Feature: Get issued credentials of a given connection

    Scenario: Provide valid and required connection_id
        Given I have passed connection_id.
        # src\issue-credential\controller\controller.ts -> NATS call for topic 'ATTESTATION_MANAGER_SERVICE/getIssueCredentials'
        When passed valid connection_id.
        Then I should get the list of Credentials Issued.
