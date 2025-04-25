Feature: Credentials proofs are generated and accepted 

    Scenario: Verifier requests credential proof from holder
        Given an issued credential
        When a verifier requests credential proof
            And the proof request is listed
        Then proof request exists


    Scenario: Holder accepts proof request from verifier
        Given an issued credential
        When a verifier requests credential proof
            And holder accepts proof request
        Then the credential is proofed