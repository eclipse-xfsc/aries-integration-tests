from behave import *
from helper import create_invitation, get_connection_id, receive_invitation, create_connection_to_self
from init import step_init, step_register_issuer_did
from schema import post_schema_complete, error_409



@when(u'User Alpha creates connection invitation')
def create_invitation_url(context):
    response = create_invitation(url_base=context.connection_manager_base_URL, tenant_id=context.issuer_id)
    
    assert response.status_code == 201
    context.invitation_url =  response.json()["data"]["invitationUrl"]

@when(u'User Beta accepts connection invitation')
def accept_invititation(context, url_base=None, tenant_id=None):
    if url_base is None:
        url_base = context.beta_connection_manager_base_URL

    if tenant_id is None:
        tenant_id = context.holder_id

    context.response = receive_invitation(url_base,
                                          tenant_id,
                                          invitation_url=context.invitation_url)
    
    context.issuer_holder_connection_id_for_holder = context.response.json()["data"]["id"]


@then(u'successful connection response is returned')
def step_impl(context):
    context.response.status_code == 201


@when(u'I request to create connection to self')
def make_connection_to_self(context):
    context.response = create_connection_to_self(url_base=context.connection_manager_base_URL, 
                                                 tenant_id=context.issuer_id)
    
    assert context.response.status_code == 201
    context.issuer_self_connection_id = context.response.json()["data"]["id"]


@when(u'I list all existing connections')
def step_impl(context):
    context.response = get_connection_id(url_base=context.connection_manager_base_URL, 
                                         tenant_id=context.issuer_id)


@then(u'All existing connections returned')
def step_impl(context):
    assert context.response.status_code == 200
    assert context.response.json()["data"] != None