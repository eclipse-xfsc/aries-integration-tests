As policy administrator
I want to have distributed cache feature provided
So I am able to use cache functionality in my custom policies

Scenario: Working with cache
Given one policy to set the value in the cache is uploaded to the system
And the second policy to get the value from the cache is uploaded to the system as well
When I evaluate policy to set the value in the cache
And get a successful response
When I evaluate policy to get the value from the cache
Then I get a successful response
And response body is not empty


Acceptance criteria:
- The plugin for rego language to get/set values is ready to use
- The working example how to use the plugin
- Green test based on example commited to the system
  

