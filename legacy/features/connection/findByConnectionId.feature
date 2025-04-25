Feature: Get connection details By Id
    Return the single connection details

    Scenario: Provide valid connection ID
        Given The connection ID available on agent database.
        # src/connections/controller/controller.ts-> Nats call on topic 'CONNECTION_MANAGER_SERVICE/getConnectionById'
        When  provide valid connection ID.
        Then  should return connection details.

    Scenario: Provide invalid connection ID.
        Given The connection ID available.
        # src/connections/controller/controller.ts-> Nats call on topic 'CONNECTION_MANAGER_SERVICE/getConnectionById'
        When  provide invalid connection ID.
        Then  should return no data found with satus code 404(Not Found).

    Scenario: Not Provide a connection ID.
        Given The connection ID available.
        # src/connections/controller/controller.ts-> Nats call on topic 'CONNECTION_MANAGER_SERVICE/getConnectionById'
        When  not provide connection ID.
        Then  should return connection request required Connction ID with satus code 400.