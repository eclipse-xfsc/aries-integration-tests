# As an OCM user
#     I want to create a new Schema

Feature: Create a new Schema, and list Schemas
        Create a new Schema on Ledger and save details in DB
        List all Schemas on Ledger 

        # Acronyms:
        #     DB = Database
        #     DID = Decentralized Identifier

    Background: 
       Given I can connect to OCM Engine

    Scenario: Register valid Schema Details
        Given I register a DID for 'issuer' 
        When I register a new schema
        Then schema is created on the Ledger

    # no name at all?
    Scenario Outline: Scenario Outline name: Attempting to register a Schema with empty details results in error 
        Given I register a DID for 'issuer' 
        When I register a new schema with a <schema_name>, <issuer_did>, <version> and <attribute_name>
        Then I get HTTP status code 400 Bad Request.
            # And I get a descriptive <error_message>
    # Schema_name and issuer_did generated during test run
    # Below can be expanded to have corresponding bad request message
    Examples: 
        | schema_name | issuer_did | version | attribute_name | 
        | False       | True       | "1.0.0" | "attribute" |
        | True        | False      | "1.0.0" | "attribute" |
        | True        | True       | ""      | "attribute" |
        | True        | True       | "1.0.0" | "" |

    Scenario: Provide duplicate name and version of the existing Schema.
        Given I register a DID for 'issuer' 
        When I register a new schema
            And I register the same schema
        Then I get HTTP status code 409 Conflict.


    Scenario: List schemas by issuer id.
        Given I have a schema registered.
        When fetch schema via issuer id.
        Then I get the schema
    

    Scenario: List schema error on invalid issuer id.
        Given I have a schema registered.
        When fetch schema via invalid issuer id.
        Then I get HTTP status code 400 Bad Request.
