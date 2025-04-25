As an OCM user
    I want to get the credentialType details of a given type

Feature: Get CredentialType details
        Get the details of credentialType of given type

    Scenario: Provide valid and required type
        Given I have passed type.
        # src\issue-credential\controller\controller.ts -> NATS call for topic 'ATTESTATION_MANAGER_SERVICE/getCredentialsTypeDetails'
        When passed valid type.
        Then I should get the details of the CredentialType.