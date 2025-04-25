As user
I want to evaluate the policy asyncronously
So I am able to execute the developed Rego code in the future non-blocking

Scenario: Evaluate the policy asyncronously
Given long running policy is uploaded to the system
And the task template is uploaded to the system
When I evaluate the policy asyncronously 
And the task template is specifyed as an input
When I get successful response
And the response contains taskId

Scenario: Getting the result for the executed policy
Given long running policy is executed
When I request the result of execution
And request contains the taskId
And the task has finished
Then I get successful response
And esponse contains the result of execution of the policy

Acceptance criteria:
- HTTP endpoints to evalute the policy asyncronously and get the result
- example of long-running policy commited to Git repo
- Green test based on example commited to the system
