Feature: OCM.E1 CredentialManager
  
  **CRM**
    *Credential Manager*.
  **BCE**
    Block Connection Endpoint.
  **SSIAS**
    SSI Abstraction Service.

    Background: 
    Instance A is running
    Instance B is running
    REST Interfaces are running
    NATS Interfaces are running
    Endpoints in the Attestation Manager of the OCM are provided
    CRM is running
    And SSIAS is running
   
   Scenario Outline: Offerings are processed
  # [IDM.OCM.E1.00015]
    Given connection is established between instance a and instance b
    When an offering is send from instance a to instance b and the offering is accepted from instance b
    Then offering is received properly
      And credential is retreated
      And I should get the HTTP status code 202 Accepted and the updated credential offer Details.
     

  Scenario Outline:  A OCM User wants to revoke a credential
  # [IDM.OCM.E1.00016]
  
    Given connection is established between instance a and instance b and a credential is send from instance b to instance a   
    When a revocation request is send from instance b to the revocation endpoint
    Then the credential is revoked
      And  instance a is not longer able to use the credential

Scenario Outline:  A OCM User wants to auto reissue a credential ?????
  # [IDM.OCM.E1.00017]
  
    Given connection is established between instance a and instance b and a credential is send from instance b to instance a   
    When a revocation request is send from instance b to the revocation endpoint
    Then the credential is revoked
      And  instance a is not longer able to use the credential
  # ????Nicht klar????

  Scenario Outline:  OCM a credential will be autorevoked
  # [IDM.OCM.E1.00018]
  
    Given connection is established between instance a and instance b and a credential is send from instance b to instance a   
    When the expirey date of this credential is "date"
    Then the credential is <action>

  Examples:
    | date    | action |
    | actual date | revoked  |
    | actual date + 1 | revoked |
    | actual date - 1| valid |


# not clear what additional parameters are
Scenario Outline:  OCM a credential will be autorevoked by additional parameter
  # [IDM.OCM.E1.00018]  
    Given connection is established between instance a and instance b and a credential is send from instance b to instance a   
    When the expirey date of this credential is "date"
    Then the credential is <action>
  # not clear what blocking additional parameters are
  Examples:
    | date    | additionalParameter | action |
    | actual date - 1| blocks | revoked |
    | actual date - 1| notblocking | revoked |

  Scenario Outline:  OCM User will refresh credential
  # [IDM.OCM.E1.00019]  
    Given connection is established between instance a and instance b and a credential is send from instance b to instance 
    When the credential is autoreissued and a verifiable presentation is not created 
    Then The user can refresh the credential
    Then the credential is set with a new expirey date

  Scenario Outline:  OCM User can not refresh credential
  # [IDM.OCM.E1.00019]  
    Given connection is established between instance a and instance b and a credential is send from instance b to instance 
    When the credential is autoreissued and a verifiable presentation is created 
    Then The user can not refresh the credential
    Then the credential is not set with a new expirey date

Scenario Outline:  Auto-accept Self-issued Credentials
    Given a connection is established with the DID ID of the OCM instance a
    When credential is send
    Then credential is accepted
