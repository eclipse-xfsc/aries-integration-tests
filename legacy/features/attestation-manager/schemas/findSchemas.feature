As an OCM user
    I want to get list of all the Schemas

Feature: Get All Schemas
        Get All Schemas from the DB

    Scenario: Provide valid page and page size.
        Given I have passed the required page and page size.
        # src\schemas\controller\controller.ts -> REST API with GET method -> schemas/
        When passed details are valid.
        Then I should get the HTTP status code 200 Ok and list of Schemas from the DB.