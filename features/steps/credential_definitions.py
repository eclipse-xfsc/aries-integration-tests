from behave import *
from helper import post_credential_definition, list_credential_definitions
from schema import post_schema_complete


@when(u'I register a credential definition')
def post_credential_def(context, supportsRevocation=False):
    response = post_credential_definition(context.schema_manager_base_URL,
                                          context.issuer_id,
                                          context.issuer_did,
                                          context.schema_id,
                                          supportsRevocation=supportsRevocation)
    
    assert response.status_code == 201
    context.credential_definition_id = response.json()["data"]["credentialDefinitionId"]
    if supportsRevocation:
        context.revocation_registry_definition_id = response.json()["data"]["revocationRegistryDefinitionId"]

@then(u'credential definition is created on the Ledger')
def step_impl(context):
    assert context.credential_definition_id != None


@when(u'I register a credential definition with a {schema_id}, {issuer_id}, and {issuer_did}')
def step_impl(context, schema_id, issuer_id, issuer_did):
    
    if issuer_id == True:
        issuer_id = context.issuer_id
    else:
        issuer_id = ""
        

    if issuer_did == True:
        issuer_did = context.issuer_did
    else:
        issuer_did = ""

    if schema_id == True:
        schema_id = context.schema_id
    else:
        schema_id = ""

    context.bad_request_response = post_credential_definition(context.schema_manager_base_URL,
                                                            issuer_id,
                                                            issuer_did,
                                                            schema_id)
    

@given(u'I have a credential definition registered')
def step_impl(context):
    # Goes as far to create a new Schema with tenantDID+ID
    post_schema_complete(context)
    post_credential_def(context)


@when(u'I register the same credential definition')
def step_impl(context):
    context.conflict_response = post_credential_definition(context.schema_manager_base_URL,
                                                                       context.issuer_id,
                                                                       context.issuer_did,
                                                                       context.schema_id)


@when(u'I list the credential definition')
def step_impl(context):
    context.response = list_credential_definitions(context.schema_manager_base_URL,
                                                   context.issuer_id)

@then(u'I get a list of credential definitions')
def step_impl(context):
    assert context.response.json()["data"] != None