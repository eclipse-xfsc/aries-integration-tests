Feature: Issued credentials can be revoked

    Scenario: An issued revocable credential gets revoked
        Given an issued revocable credential
        When the issuer revokes the credential
        Then the credential is revoked

    # Scenario: An issued unrevocable credential gets error on revocation attempt
    #     Given an issued unrevocable credential
    #         And connection between holder and verifier established
    #     When the issuer revokes the credential
    #     Then an error message is presented