from behave import *
from helper import get_tenant_holder_connection_id_for_tenant, make_credential_offer, get_credential_offer, accept_credential_offer, get_credentials, create_credential_offer_to_self
from schema import post_schema_complete
from credential_definitions import post_credential_def
from connection import create_invitation_url, accept_invititation, make_connection_to_self


@given(u'issuer to holder connection established')
def connection_established(context, supportsRevocation=False):
    post_schema_complete(context)
    post_credential_def(context, supportsRevocation=supportsRevocation)
    create_invitation_url(context)
    accept_invititation(context, 
                        url_base=context.connection_manager_base_URL,
                        tenant_id=context.holder_id_2)

    context.issuer_holder_connection_id_for_issuer = get_tenant_holder_connection_id_for_tenant(url_base=context.connection_manager_base_URL, 
                                                 tenant_id=context.issuer_id)
    

@when(u'issuer makes a credential offer')
def credential_offer(context):
    context.response = make_credential_offer(context.credential_manager_base_URL, 
                                             context.issuer_id,
                                             context.issuer_holder_connection_id_for_issuer,
                                             context.credential_definition_id)


@then(u'a credential offer exists')
def step_impl(context):
    assert context.response.status_code == 201
    assert context.response.json()["data"]["credentials"] != None


@when(u'holder accepts credential offer')
def holder_accepts_offer(context):
    context.holder_credential_offer_id = get_credential_offer(url_base=context.credential_manager_base_URL,
                                                              tenant_id=context.holder_id_2)
    
    context.response = accept_credential_offer(url_base=context.credential_manager_base_URL,
                                               tenant_id=context.holder_id_2,
                                               holder_credential_offer_id=context.holder_credential_offer_id)


@then(u'holder receives new credentials')
def get_credential(context):
    assert context.response.status_code == 201
    credentials = get_credentials(url_base=context.credential_manager_base_URL, tenant_id=context.holder_id_2)
    assert credentials.json()["data"][0] != None


@given(u'issuer to self connection established')
def step_impl(context):
    post_schema_complete(context)
    post_credential_def(context)
    make_connection_to_self(context)


@when(u'issuer self issues credential')
def step_impl(context):
    context.reponse = create_credential_offer_to_self(url_base=context.credential_manager_base_URL,
                                    tenant_id=context.issuer_id,
                                    credential_definition_id=context.credential_definition_id)


@then(u'issuer receives new credentials')
def step_impl(context):
    credentials = get_credentials(url_base=context.credential_manager_base_URL, tenant_id=context.issuer_id)
    assert credentials.json()["data"][0] != None
