As an OCM user
    I want to get the Schema by id

Feature: Get Schema by Id
        Get Schema by the given schema id

    Scenario: Provide valid schema id.
        Given I have passed the required schema id.
        # src\schemas\controller\controller.ts -> REST API with GET method -> schemas/:id
        When passed schema id is valid.
        Then I should get the HTTP status code 200 Ok and Schema from the DB.

    Scenario: Provide invalid schema id.
        Given I have passed the required schema id.
        # src\schemas\controller\controller.ts -> REST API with GET method -> schemas/:id
        When passed schema id is invalid.
        Then I should get the HTTP status code 404 Not Found.
