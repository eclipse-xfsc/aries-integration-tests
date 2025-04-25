As an OCM user
    I want to create a new Credential Definition

Feature: Create a new Credential Definition
        Create a new Credential Definition on Ledger and save details in DB

    Scenario: Provide valid and required Credential Definition Details
        Given I have passed all required credential definition details.
        # src\credentialDef\controller\controller.ts -> REST API with POST method -> credentialDef/
        When passed all valid credential definition details.
        Then credential definition should be created on the Ledger with the given details.
        And should return the newly created credential definition id.
        And store the details in DB.
        And I should get the HTTP status code 201 Created and the created Credential Definition Details.

    Scenario: Provide invalid schemaID, name, created_by, is_revokable or is_auto_issue
        Given I have passed schemaID, name, created_by, is_revokable and is_auto_issue.
        # src\credentialDef\controller\controller.ts -> REST API with POST method -> credentialDef/
        When  passed invalid schemaID, name, created_by, is_revokable or is_auto_issue.
        Then  I should get HTTP status code 400 Bad Request.

    Scenario: Provide name and schemaID of the existing Credential Definition.
        Given I have passed all required credential definition details.
        # src\credentialDef\controller\controller.ts -> REST API with POST method -> credentialDef/
        When  passed name and schemaID of the existing Credential Definition.
        Then  I should get HTTP status code 409 Conflict.