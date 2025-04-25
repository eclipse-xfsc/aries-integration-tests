As user
I want to evaluate the policy
So I am able to execute it in the future

Scenario: Execute the policy
When I upload the policy to repository
And set the policy to productive
And the policy successfully uploaded to the system
When I execute the policy
Then I get successful response
And response contains the result of execution of the policy

Acceptance criteria:
- HTTP endpoint to evaluate the policy
- example policy created and commited to Git repo
- Green test based on example commited to the system