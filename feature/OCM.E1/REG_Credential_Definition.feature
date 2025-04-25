Feature: Create a new Credential Definition on Ledger and save details in DB
  
Scenario: Provide valid and required Credential Definition Details
        Given I have passed all required credential definition details.
        # src\credentialDef\controller\controller.ts -> REST API with POST method -> credentialDef/
        When passed all valid credential definition details.
        Then credential definition should be created on the Ledger with the given details.
        And should return the newly created credential definition id.
        And store the details in DB.
        And I should get the HTTP status code 201 Created and the created Credential Definition Details.
