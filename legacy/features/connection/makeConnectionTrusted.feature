Feature: Make connection trusted against connection ID.
     I want to Update connection  status to trusted.

    Scenario: Make connection trusted against connection ID.
        Given I have pass connection ID.
        # src/connections/controller/controller.ts-> Nats call on topic 'CONNECTION_MANAGER_SERVICE/makeConnectionTrusted'
        When  I have pass valid connection ID.
        Then  should update current connection state to trusted state.

    Scenario: Make connection trusted against connection ID.
        Given I have pass connection ID.
        # src/connections/controller/controller.ts-> Nats call on topic 'CONNECTION_MANAGER_SERVICE/makeConnectionTrusted'
        When  I have pass invalid connection ID.
        Then  should get http status 404(Not Found).

    Scenario: Make connection trusted against connection ID.
        # src/connections/controller/controller.ts-> Nats call on topic 'CONNECTION_MANAGER_SERVICE/makeConnectionTrusted'
        Given I have not pass connection ID.
        Then  should return connection request required Connction ID with state code 400(Bad request).