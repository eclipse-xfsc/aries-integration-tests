from behave import *
from helper import get_credentials, make_credential_offer_with_revocation, revoke_credential
from schema import post_schema_complete
from credential_definitions import post_credential_def
from issue_credentials import connection_established, credential_offer, holder_accepts_offer



@given(u'an issued revocable credential')
def step_impl(context):
    connection_established(context, supportsRevocation=True)
    # credential_offer(context)
    make_credential_offer_with_revocation(context.credential_manager_base_URL, 
                                             context.issuer_id,
                                             context.issuer_holder_connection_id_for_issuer,
                                             context.credential_definition_id,
                                             context.revocation_registry_definition_id)


    holder_accepts_offer(context)


@when(u'the issuer revokes the credential')
def step_impl(context):
    credentials = get_credentials(url_base=context.credential_manager_base_URL, tenant_id=context.holder_id_2)
    credential_id = credentials.json()["data"][0]["id"]

    context.response = revoke_credential(url_base=context.credential_manager_base_URL, tenant_id=context.issuer_id, credential_id=credential_id)

@then(u'the credential is revoked')
def step_impl(context):
    assert context.response.status_code == 201