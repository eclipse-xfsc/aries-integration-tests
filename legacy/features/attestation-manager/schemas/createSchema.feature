As an OCM user
    I want to create a new Schema

Feature: Create a new Schema
        Create a new Schema on Ledger and save details in DB

    Scenario: Provide valid and required Schema Details
        Given I have passed all required schema details.
        # src\schemas\controller\controller.ts -> REST API with POST method -> schemas/
        When passed all valid schema details.
        Then schema should be created on the Ledger with the given details.
        And should return the newly created Schema_ID.
        And store the details in DB.
        And I should get the HTTP status code 201 Created and the created Schema Details.

    Scenario: Provide invalid name, created_by, version or attributes
        Given I have passed name, created_by, version and attributes.
        # src\schemas\controller\controller.ts -> REST API with POST method -> schemas/
        When  passed invalid name, created_by, version or attributes.
        Then  I should get the HTTP status code 400 Bad Request.

    Scenario: Provide name and version of the existing Schema.
        Given I have passed all required schema details.
        # src\schemas\controller\controller.ts -> REST API with POST method -> schemas/
        When  passed name and version of the existing Schema.
        Then  I should get the HTTP status code 409 Conflict.