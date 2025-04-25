As an OCM user
    I want to save the credential details from Webhook emitted by AFJ Agent

Feature: Credentials Webhook
        Credential Webhook Emitted by AFJ

    Scenario: A new Credential is offered
        Given AFJ Agent have passed created credential details.
        # src\issue-credential\controller\controller.ts -> NATS call for topic 'ATTESTATION_MANAGER_SERVICE/CredentialStateChanged'
        When passed credential state is OFFER_SENT.
        Then credential should be created in DB.
        And I should get the HTTP status code 201 Created and the created credential Details.

    Scenario: A Credential's state is changed
        Given AFJ have passed the updated credential details.
        # src\issue-credential\controller\controller.ts -> NATS call for topic 'ATTESTATION_MANAGER_SERVICE/CredentialStateChanged'
        When passed credential state is not OFFER_SENT.
        Then credential state should be updated in DB.
        And I should get the HTTP status code 202 Accepted and the updated credential Details.
