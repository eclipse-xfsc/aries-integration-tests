As an OCM user
    I want to create a new Schema

@IDM.OCM.E1.00014
Feature: Create a new Schema on Ledger and save details in DB

    Scenario: Provide valid and required Schema Details
        Given I have passed all required schema details.
        # src\schemas\controller\controller.ts -> REST API with POST method -> schemas/
        When passed all valid schema details.
        Then schema should be created on the Ledger with the given details.
            And should return the newly created Schema_ID.
            And store the details in DB.
            And I should get the HTTP status code 201 Created and the created Schema Details.
