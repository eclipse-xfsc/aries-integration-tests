  Get Connection details
    Return the list of connections or single connection created on the OCM environment

     Scenario: Connection details by ID.
      # src/connections/controller/controller.ts-> Rest API with Get Method -> connections/:connectionId? 
        When  passed valid connection ID.
        Then  returns connection details.

    Scenario: Connection details.
      # src/connections/controller/controller.ts-> Rest API with Get Method -> connections/:connectionId? 
        When  passed valid pageSize and Number of records.
        Then  returns a list of connection details.

        Scenario: Connection details with status.
        # src/connections/controller/controller.ts-> Rest API with Get Method -> connections/:connectionId? 
        When passed valid pageSize and Number of records.
        And status
        Then returns a list of connection details with provided status.


