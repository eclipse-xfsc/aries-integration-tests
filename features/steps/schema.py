from behave import *
import json
from helper import generate_random_string, post_schemas, get_schemas
from init import step_init, step_register_issuer_did


@when(u'I register a new schema')
def post_schema(context, issuer_did = None):
    context.schema_name = "ocm_e2e_example_schema_" + generate_random_string(15)

    response = post_schemas(url_base=context.schema_manager_base_URL, 
                            issuer_id=context.issuer_id, 
                            issuer_did=context.issuer_did,
                            schema_name=context.schema_name
                            )
    
    assert response.status_code == 201
    context.schema_id = response.json()["data"]["schemaId"]
    assert context.schema_id is not None

@then(u'schema is created on the Ledger')
def get_schema(context):
    response = get_schemas(context.schema_manager_base_URL,
                context.issuer_id)

    assert response.status_code == 200
    assert response.json()["data"][0]["name"] == context.schema_name

    return response

@when(u'I register a new schema with a {schema_name}, {issuer_did}, {version} and {attribute_name}')
def step_impl(context, schema_name, issuer_did, version, attribute_name):
    if schema_name == False:
        schema_name = ""
    else:
        schema_name = "ocm_e2e_example_schema_" + generate_random_string(15)

    if issuer_did == False:
        issuer_did = ""
    else:
        issuer_did = context.issuer_did
    
    schema_payload = json.dumps({
        "issuerDid": issuer_did,
        "name": schema_name,
        "version": version,
        "attributeNames": [
            attribute_name
        ]
    })

    context.bad_request_response = post_schemas(
        context.schema_manager_base_URL, 
        context.issuer_id,
        issuer_did,
        schema_name,
        payload=schema_payload)
    
@then(u'I get HTTP status code 400 Bad Request.')
def step_impl(context):
    assert context.bad_request_response.status_code == 400

@when(u'I register the same schema')
def step_impl(context):
    context.conflict_response = post_schemas(url_base=context.schema_manager_base_URL, 
                                                        issuer_id=context.issuer_id, 
                                                        issuer_did=context.issuer_did,
                                                        schema_name=context.schema_name
                                                        )

@then(u'I get HTTP status code 409 Conflict.')
def error_409(context):
    assert context.conflict_response.status_code == 409

@given(u'I have a schema registered.')
def post_schema_complete(context):
    step_init(context)
    step_register_issuer_did(context)
    post_schema(context)

@when(u'fetch schema via issuer id.')
def step_impl(context):
    context.schema_response = get_schema(context)
    

@then(u'I get the schema')
def step_impl(context):
    assert context.schema_response.json()["data"][0]["version"] == "1.0.0"
    assert context.schema_response.json()["data"][0]["attrNames"] != None
    # Add more asserts here

@when(u'fetch schema via invalid issuer id.')
def step_impl(context):
  
    url = context.schema_manager_base_URL+'/v1/schemas?tenantId='+context.issuer_id    
    context.bad_request_response = get_schemas(context.schema_manager_base_URL,
                                             issuer_id="")


@then(u'I get HTTP status code 404 Not Found.')
def step_impl(context):

    assert context.not_found_response.status_code == 404