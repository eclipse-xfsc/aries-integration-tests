As an OCM user
    I want to create a new CredentialType

Feature: Create a new CredentialType
        Create a new CredentialType

    Scenario: Provide valid and required CredentialType Details
        Given I have passed all required credentialType details.
        # src\issue-credential\controller\controller.ts -> REST API with POST method -> credentialType/
        When passed all valid credentialType details.
        Then credentialType should be created in DB.
        And I should get the HTTP status code 201 Created and the created CredentialType Details.

    Scenario: Provide invalid schema_id or type
        Given I have passed schema_id and type.
        # src\issue-credential\controller\controller.ts -> REST API with POST method -> credentialType/
        When  passed invalid schema_id or type.
        Then  I should get HTTP status code 400 Bad Request.