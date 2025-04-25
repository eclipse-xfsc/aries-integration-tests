@idm-ocm-e1-00000
Feature: Create, list and accept connections
  
    DID = Decentralized Identifier

        
  @idm-ocm-e1-00006 
  @idm-ocm-e1-00010
  Scenario: A User establishes a connection, on connection invite being accepted
    Given I have a credential definition registered
    When User Alpha creates connection invitation
        And User Beta accepts connection invitation   
    Then successful connection response is returned
      

#   @idm-ocm-e1-00007 
#   @idm-ocm-e1-00010
#   Scenario: Connection attempt with a blocked connection fails
#     Given DID is blocked
#     When User Alpha creates connection invitation
#     Then unsuccessful connection response returned


  @idm-ocm-e1-00008 
  @idm-ocm-e1-00009
  Scenario: Auto-accept Connections to Self
    Given I have a credential definition registered
    When I request to create connection to self
    Then successful connection response is returned

  # @idm-ocm-e1-00008 
  # @idm-ocm-e1-00009
  # Scenario: Failed auto-accept connection attempt, using empty DID
  # #Scenario Number 5 in OCM_PCM_Test_Ideas_New_Version.xlsx
  #   Given I have a credential definition registered
  #   Given DID is empty
  #   When I request to create connection to self
  #   Then unsuccessful connection response returned

    
    # [IDM.OCM.E1.00011] Connection List Endpoint - list all exisitng connections
    # [IDM.OCM.E1.00059] Blocked connection is discoverable by listing all connections, and displayed as blocked
    # The Connection Manager MUST provide an Endpoint to List all existing connections. 
    # After talk with Steffen: Not relevant for BDD -> Unit tes

    @idm-ocm-e1-00011
    @idm-ocm-e1-00059
    Scenario: A list of all existing connections is provided by an endpoint
    # [IDM.OCM.E1.00011]
      Given I have a credential definition registered
      When User Alpha creates connection invitation
        And User Beta accepts connection invitation 
        And I list all existing connections
      Then All existing connections returned
