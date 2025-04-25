As an OCM user
    I want to get all Credential Definitions by schema id
@IDM.OCM.E1.00015
@IDM.OCM.E1.00014
Feature: Get All Credential Definitions from the DB by given schema id

    Scenario: Provide valid schema id, page and page size.
        Given I have passed the required schema id, page and page size.
        # src\credentialDef\controller\controller.ts -> REST API with GET method -> credentialDef/
        When passed details are valid.
        Then I should get the HTTP status code 200 Ok and list of Credential Definitions from the DB.