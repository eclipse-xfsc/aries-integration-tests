As a OCM Admin 
    I want to verify credentials.

Scenario: OCM admin verify credentials
    Given PCM user should hold credentials in there wallet.
    And   PCM user connection must be in trusted state with verifer.
    # controller.ts-> Rest API with Post method -> send-presentation-request
    When  OCM verifer orgnization sends a proof presentation request with following fields ( connectionId, schemaId or credentialDefId, attributes ) to PCM user.
    And   PCM user share the attributes from requested credentials to OCM verifer.
    And   OCM verifer verify the presentation acknowledgement.    
    Then  Presentation request should be in 'verified' state.

Scenario: PCM user decline proof request
    Given PCM user should hold credentials in there wallet.
    And   PCM user connection must be in trusted state with verifer.
    When  OCM verifer orgnization sends a proof presentation request with following fields ( connectionId, schemaId or credentialDefId, attributes ) to PCM user.
    And   PCM user declines the presentation request.
    Then  Presentation request is not 'verified'.  

