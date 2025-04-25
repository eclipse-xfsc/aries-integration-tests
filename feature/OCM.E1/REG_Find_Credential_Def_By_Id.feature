As an OCM user
    I want to find Credential Definition by id
@IDM.OCM.E1.00015
Feature: Get Credential Definition by the given cred_def_id

    Scenario: Provide valid cred_def_id.
        Given I have passed the required cred_def_id.
        # src\credentialDef\controller\controller.ts -> REST API with GET method -> credentialDef/:id
        When passed cred_def_id is valid.
        Then I should get the HTTP status code 200 Ok and Credential Definition from the DB.