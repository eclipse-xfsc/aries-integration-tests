As an OCM user
    I want to accept a credential offer
@IDM.OCM.E1.00015
Feature: Accept a credential offer

    Scenario: Provide valid and required credentialId
        Given I have passed all required details.
        # src\issue-credential\controller\controller.ts -> REST API with POST method -> accept-request/
        When passed all valid accept offer credential details.
        Then credential offer should get accepted.
            And I should get the HTTP status code 202 Accepted and the updated credential offer Details.
                    