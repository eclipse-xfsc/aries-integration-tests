Feature: Create, Accept and View Credentials


    Scenario: Issuer makes a credential offer
        Given issuer to holder connection established
        When issuer makes a credential offer
        Then a credential offer exists


    Scenario: Holder accepts credential offer
        Given issuer to holder connection established
        When issuer makes a credential offer
            And holder accepts credential offer
        Then holder receives new credentials


    # Scenario: Holder credentials are listed
    #     Given issuer to holder connection established
    #     When issuer makes a credential offer
    #        And holder accepts credential offer
    #     When holder credentials are listed
    #     Then holder credentials visible 

    Scenario: Issuer self-issues credential
        Given issuer to self connection established
        When issuer self issues credential
        Then issuer receives new credentials
