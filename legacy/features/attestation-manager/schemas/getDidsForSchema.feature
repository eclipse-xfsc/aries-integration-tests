As an OCM user
    I want to get all principal DIDs for a given schema id

Feature: Get all DIDs for Schema
        Get all principal DIDs for a given schema id

    Scenario: Provide valid schema id.
        Given I have passed the required schema id.
        # src\schemas\controller\controller.ts -> REST API with GET method -> get-dids-for-schema/:id
        When passed schema id is valid.
        Then I should get the HTTP status code 200 Ok and Schema DIDs from the DB.

    Scenario: Provide invalid schema id.
        Given I have passed the required schema id.
        # src\schemas\controller\controller.ts -> REST API with GET method -> get-dids-for-schema/:id
        When passed schema id is invalid.
        Then I should get the HTTP status code 404 Not Found.