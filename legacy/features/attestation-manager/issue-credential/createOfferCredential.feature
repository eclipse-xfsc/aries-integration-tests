As an OCM user
    I want to create credential offer

Feature: Create offer credential
        Create a credential offer

    Scenario: Provide valid and required connectionId, credentialDefinitionId, comment, preview and autoAcceptCredential
        Given I have passed all required offer credential details.
        # src\issue-credential\controller\controller.ts -> REST API with POST method -> create-offer-credential/
        When passed all valid offer credential details.
        Then credential offer should be sent to the given connection.
        And I should get the HTTP status code 201 Created and the created credential offer Details.