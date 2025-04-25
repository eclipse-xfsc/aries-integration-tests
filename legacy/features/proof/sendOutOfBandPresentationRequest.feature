As a OCM Admin 
    I want to verify credentials without connection.

Scenario: OCM admin verify credentials
    Given PCM user should hold credentials in there wallet.
    # controller.ts-> Rest API with Post method -> send-out-of-band-presentation-request
    When  OCM verifer orgnization sends a proof presentation request with following fields ( schemaId or credentialDefId, attributes ) to PCM user.
    And   PCM user share the attributes from requested credentials to OCM verifer.
    And   OCM verifer verify the presentation acknowledgement.    
    Then  Presentation request should be in 'verified' state.

Scenario: OCM admin verify credentials
    Given PCM user should hold credentials in there wallet.
    # controller.ts-> Rest API with Post method -> accept-presentation
    When  OCM admin send a credential request to PCM user.
    And   PCM user decline the credential request witch will requested from OCM admin. 


    Scenario: OCM admin verify credentials agenst credentialType
    Given PCM user should hold credentials in there wallet.
    # controller.ts-> Rest API with Post method -> out-of-band-proof
    When  OCM verifer orgnization sends a proof presentation request with following fields ( schemaId or credentialDefId, attributes ) to PCM user.
    And   provide credentialType
    And   PCM user share the attributes from requested credentials to OCM verifer.
    And   OCM verifer verify the presentation acknowledgement.    
    Then  Presentation request should be in 'verified' state.  
