Feature: Get Proof Presentation By Id
        Return the single proof presentation details

Scenario: Provide valid presentation id
    Given The presentation id is available on agent database.
    # controller.ts-> Rest API with GET method -> find-by-presentation-id
    When  provide valid presentation id.
    Then  should return proof presentation details.

Scenario: Provide invalid presentation id
    Given The presentation id available.
    # controller.ts-> Rest API with GET method -> find-by-presentation-id
    When  provide invalid presentation id.
    Then  should return no data found with status code 404.

Scenario: Provide validated page and pageSize
    Given proof presentation data available on OCM database. 
    # controller.ts-> Rest API with GET method -> find-proof-presentation
    When  passed valid page.
    And   passed valid pageSize.
    Then  should get proof presentation list.

Scenario: Provide validated page and pageSize
    Given proof presentation data is not available on OCM database.
    # controller.ts-> Rest API with GET method -> find-proof-presentation
    When  passed valid page.
    And   passed valid pageSize.
    Then  should get http status 404.
    
Scenario: Not provide a presentation id
    Given The presentation id available.
    # controller.ts-> Rest API with GET method -> find-by-presentation-id
    When  not provide presentation id.
    Then  should return presentation request required following attributes ( presentation_id ) with status code 400.