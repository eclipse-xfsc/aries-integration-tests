Scheduler is running on Background to delete Non-trusted and Non-complete connections.

    Scenario: Delete a Non-complete connection.
    When connection does not goes in complete state within 30 minutes
    # /src/connections/scheduler/scheduler.service.ts -> expireNonCompleteConnection()
    Then connection will get deleted from database.

    Scenario: Delete a Non-trusted connection.
    When connection does not goes in trusted state within 30 minutes
    # /src/connections/scheduler/scheduler.service.ts -> expireNonTrustedConnection()
    Then connection will get deleted from database.
