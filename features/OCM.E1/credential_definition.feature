Feature: Create and list all Credential Definitions
        Create a new Credential Definition on Ledger
        List all Credential Definition on Ledger 

    Scenario: Register valid Credential Definition
        Given I have a schema registered.
        When I register a credential definition 
        Then credential definition is created on the Ledger
        # Include assertion for credential id, and status code 201

    Scenario Outline: Register invalid schemaID, issuerID, or issuerDID produces error result
        Given I have a schema registered.
        When I register a credential definition with a <schema_id>, <issuer_id>, and <issuer_did>
        Then I get HTTP status code 400 Bad Request.
    Examples:
        | schema_id | issuer_id | issuer_did |
        | False     | True      | True       |
        | True      | False     | True       |
        | True      | True      | False      |

    Scenario: Register a duplicate Credential Definition.
        Given I have a credential definition registered
        When  I register the same credential definition
        Then  I get HTTP status code 409 Conflict.

    Scenario: List all credential definitions by issuer ID
        Given I have a credential definition registered
        When I list the credential definition
        Then I get a list of credential definitions
    