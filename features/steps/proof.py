from behave import *
from helper import create_invitation, receive_invitation, get_tenant_holder_connection_id_for_tenant, request_credential_proof, get_tenant_proof_request, accept_proof_request
from schema import post_schema_complete
from credential_definitions import post_credential_def
from issue_credentials import connection_established, credential_offer, holder_accepts_offer

@given(u'an issued credential')
def step_impl(context):
    connection_established(context)
    credential_offer(context)
    holder_accepts_offer(context)


@when(u'a verifier requests credential proof')
def step_impl(context):
    # context.verifier_id
    response = create_invitation(url_base=context.connection_manager_base_URL, tenant_id=context.verifier_id)
    invitation_url =  response.json()["data"]["invitationUrl"]

    context.response = receive_invitation(url_base=context.connection_manager_base_URL,
                                          tenant_id=context.holder_id_2,
                                          invitation_url=invitation_url)
    
    verifier_holder_connection_to_verifier = get_tenant_holder_connection_id_for_tenant(url_base=context.connection_manager_base_URL,
                                               tenant_id=context.verifier_id)
    
    request_credential_proof(url_base=context.proof_manager_base_URL,
                             tenant_id=context.verifier_id,
                             connection_id=verifier_holder_connection_to_verifier)
    


@when(u'the proof request is listed')
def step_impl(context):
    context.response = get_tenant_proof_request(url_base=context.proof_manager_base_URL,
                                                tenant_id=context.verifier_id)


@then(u'proof request exists')
def step_impl(context):
    assert context.response.status_code == 200


@when(u'holder accepts proof request')
def step_impl(context):
    response = get_tenant_proof_request(url_base=context.proof_manager_base_URL,
                                        tenant_id=context.holder_id_2)
    
    context.proof_record_id = response.json()["data"][0]["id"]

    context.response = accept_proof_request(url_base=context.proof_manager_base_URL,
                                            tenant_id=context.holder_id_2,
                                            proof_record_id=context.proof_record_id)

@then(u'the credential is proofed')
def step_impl(context):
    
    assert context.response.status_code == 200
    assert context.response.json()["data"]["state"] == "presentation-sent"