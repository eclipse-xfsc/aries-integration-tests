As an OCM user
    I want to create a new CredentialType
@IDM.OCM.E1.00015
Feature: Create a new CredentialType

    Scenario: Provide valid and required CredentialType Details
        Given I have passed all required credentialType details.
        # src\issue-credential\controller\controller.ts -> REST API with POST method -> credentialType/
        When passed all valid credentialType details.
        Then credentialType should be created in DB.
        And I should get the HTTP status code 201 Created and the created CredentialType Details.


        https://gitlab.eclipse.org/tsabolov/ocm-engine.git

