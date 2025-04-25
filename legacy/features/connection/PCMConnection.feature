 As a PCM user, 
    I want to register with an organization
    So that I can leverage XFSC ecosystem

    Scenario: I want to become a member of an organization (a XFSC Participant)
        Given PCM Application should be configureameter alias set to 'member') and sends to PCM register email address.  
        When  PCM Application scans the provided d on the user device.
        # src/connections/controller/controller.ts-> Rest API POST METHOD -> NAME 'invitation-url' 
        And OCM admin generates QR code ( with parQR code.
        Then Pairwise DID and ver key is exchanged between the agents. 
        And the Connection is established between the PCM aries agent and organization aries agent.
        # Webhook call on topic 'CONNECTION_MANAGER_SERVICE/ConnectionStateChanged'
        And connection state moves to complete state.
        # Nats call on topic 'PRINCIPAL_MANAGER_SERVICE/connectionCompleteStatus'
        And Principal membership credentials are issued.

    Scenario: I want to subscribe to a service of an organization (a XFSC Participant)
        Given PCM User should be member of an organization.
        And OCM admin/portal generates QR code ( with parameter alias set to 'subscriber') and email/display on portal.
        # src/connections/controller/controller.ts-> Rest API POST METHOD -> NAME 'invitation-url'
        When  PCM Application scans the provided QR code.
        Then Pairwise DID and ver key is exchanged between the agents. 
        And the Connection is established between PCM aries agent and organization aries agent.
        # Webhook call on topic 'CONNECTION_MANAGER_SERVICE/ConnectionStateChanged'
        And connection state moves to complete state.
        # Nats call on topic 'PROOF_MANAGER_SERVICE/sendMembershipProofRequest'
        And Principal membership verification to make connection trusted. 
        And OCM admin issues the verifiable credential over a trusted connection.

