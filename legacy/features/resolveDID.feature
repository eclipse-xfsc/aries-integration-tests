As policy administrator
I want to evaluate resolving DID feature
So I am able to use my DID features in the custom policies

Scenario: DID resolution
Given DID document is published
And the policy to resolve did is uploaded to the system
When I send a request containing DID
And DID method is in the list of supported ones
Then I get successful response
And response contains DID document

Acceptance criteria:
- published did document
- plugin for rego language to get/set values is ready to use
- example of usage of the plugin commited to the system
- green tests based on example commited to the system