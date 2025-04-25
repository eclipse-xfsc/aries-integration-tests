As policy administrator
I want to have persistence functionality 
So I am able to store the json document inside of the database

Scenario: Store data inside of database
Given one policy to set the value in the database is uploaded to the system
And the second policy to query the value from the database is uploaded to the system as well
When I store the json document inside of the database
And get a successful response
When I evaluate policy to get the value from the database
Then I get a successful response
And response body is not empty

Acceptance criteria:
- plugin for rego language to set/query values is ready to use
- example of usage of the plugin commited to the system
- green tests based on example commited to the system