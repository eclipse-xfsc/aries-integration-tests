As an OCM user
    I want to get credentials

Feature: Get credential

    Scenario: Provide valid credential_id
        Given I have passed all required details.
        # src\issue-credential\controller\controller.ts -> REST API with POST method -> credential/:id
        When passed valid credential_id.
        Then I should get the HTTP status code 200 Ok and the credential Details.

    Scenario: Provide invalid credential_id
        Given I have passed all required details.
        # src\issue-credential\controller\controller.ts -> REST API with POST method -> credential/:id
        When passed invalid credential_id.
        Then I should get the HTTP status code 404 Not Found.