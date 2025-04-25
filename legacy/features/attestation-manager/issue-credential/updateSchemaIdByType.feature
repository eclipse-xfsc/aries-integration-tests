As an OCM user
    I want to update schema_id in credentialType of given type

Feature: Update schema_id by type
        update schema_id in credentialType for given type

    Scenario: Provide valid and required schema_id and type
        Given I have passed all required details.
        # src\issue-credential\controller\controller.ts -> REST API with POST method -> updateSchemaIdByType/
        When passed valid schema_id and type.
        Then credentialType should be updated.
        And I should get the HTTP status code 200 Ok and the updated credentialType Details.