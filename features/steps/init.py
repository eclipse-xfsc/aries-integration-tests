from behave import *
from helper import generate_random_string, register_endorser_did, create_issuer_tennant, register_issuer_did, create_holder_tennant, create_verifier_tennant


@given(u'I can connect to OCM Engine')
def step_init(context):
    """
    step_impl Sets up initial variables for Base URLs
    """ 
    localhost = "http://localhost:"
    context.schema_manager_base_URL = localhost + "4001"
    context.connection_manager_base_URL = localhost + "4002"
    context.credential_manager_base_URL = localhost + "4003"
    context.proof_manager_base_URL = localhost + "4004"
    context.dev_tools_base_URL = localhost + "4100"
    context.did_manager_base_URL = localhost + "4006"

    context.beta_schema_manager_base_URL = localhost + "4011"
    context.beta_connection_manager_base_URL = localhost + "4012"
    context.beta_credential_manager_base_URL = localhost + "4013"
    context.beta_proof_manager_base_URL = localhost + "4014"
    context.beta_dev_tools_base_URL = localhost + "4110"
    context.beta_did_manager_base_URL = localhost + "4016"
 
    # Register Endorser DID
    register_endorser_did(context.dev_tools_base_URL)
    register_endorser_did(context.beta_dev_tools_base_URL)

    # Create 'issuer' tenant
    create_issuer_tenant_request = create_issuer_tennant(context.dev_tools_base_URL)    
    assert create_issuer_tenant_request.status_code == 201

    create_holder_tenant_request = create_holder_tennant(context.beta_dev_tools_base_URL)    
    # assert create_holder_tenant_request.status_code == 201
    create_holder_2_tenant_request = create_holder_tennant(context.dev_tools_base_URL)

    create_verifier_tenant_request = create_verifier_tennant(context.dev_tools_base_URL)    
    assert create_verifier_tenant_request.status_code == 201

    context.issuer_id = create_issuer_tenant_request.json()['id']
   # context.holder_id = create_holder_tenant_request.json()['id']
    context.holder_id_2 = create_holder_2_tenant_request.json()['id']
    context.verifier_id = create_verifier_tenant_request.json()['id']


@given(u'I register a DID for \'issuer\'')
def step_register_issuer_did(context):

    register_did_response = register_issuer_did(context.did_manager_base_URL, issuer_id=context.issuer_id)
    
    assert register_did_response.status_code == 201
    context.issuer_did = register_did_response.json()["data"][0]