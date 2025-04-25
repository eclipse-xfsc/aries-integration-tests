Feature: I am able to prove as XFSC ecosystem member.
         To make the existing connection trusted.

Scenario: Make the existing connection trusted
    Given PCM user should hold principal membership credentials in there wallet.
    And   PCM user connection must be in complete state with verifer.
    # Nats call on topic 'PROOF_MANAGER_SERVICE/sendMembershipProofRequest'
    When  OCM verifer orgnization sends a proof presentation request with following fields ( schemaId, attributes ) to PCM user.
    And   PCM user share the attributes from requested credentials to OCM verifer.
    And   OCM verifer verify the presentation acknowledgement.    
    Then  Presentation request should be in 'trusted' state.
