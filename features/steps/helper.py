import secrets
import string
import requests
import json
import time
import random

# Lists of business jargon adjectives and nouns
business_adjectives = ["synergistic", "strategic", "innovative", "disruptive", "proactive"]
business_nouns = ["solution", "strategy", "paradigm", "optimization", "monetization"]

# Generate a random business jargon adjective and noun
def generate_random_business_name():
    random_business_adjective = random.choice(business_adjectives)
    random_business_noun = random.choice(business_nouns)

    return f"{random_business_adjective}_{random_business_noun}"

def generate_random_string(length):
    """Generate a secure random alphanumeric string of given length."""
    alphabet = string.ascii_letters + string.digits  # Include both letters and numbers
    return ''.join(secrets.choice(alphabet) for _ in range(length))


def register_endorser_did(url_base, payload={}, header={}):
    
    endorser_url = url_base+'/register-endorser-did'
    requests.post(endorser_url, headers=header, data=payload, timeout=60)


def create_issuer_tennant(url_base, 
                          payload = json.dumps({"label": "issuer"}), 
                          headers = {'Content-Type': 'application/json'}
                          ):
    
    url = url_base+"/create-tenant"
    return requests.post(url, headers=headers, data=payload, timeout=60)  


def create_holder_tennant(url_base, 
                          payload = json.dumps({"label": "holder"}), 
                          headers = {'Content-Type': 'application/json'}
                          ):
    
    url = url_base+"/create-tenant"
    return requests.post(url, headers=headers, data=payload, timeout=60)  


def create_verifier_tennant(url_base, 
                            payload = json.dumps({"label": "verifier"}), 
                            headers = {'Content-Type': 'application/json'}
                            ):
    
    url = url_base+"/create-tenant"
    return requests.post(url, headers=headers, data=payload, timeout=60)  


def register_issuer_did(url_base,
                        issuer_id, 
                        seed = None,
                        payload = None, 
                        headers = {'Content-Type': 'application/json'}
                        ):
    
    if seed is None:
        seed = generate_random_string(15) \
               + generate_random_string(1) \
               + generate_random_string(1) \
               + generate_random_string(15)
    if payload is None:
        payload = json.dumps({
                            "seed": (seed),
                            "services": [
                                {
                                "id": "#endpoint",
                                "type": "endpoint",
                                "serviceEndpoint": "https://bar.example.com"
                                },
                                {
                                "id": "#didcomm-messaging",
                                "type": "didcomm-messaging",
                                "serviceEndpoint": "https://bar.example.com"
                                },
                                {
                                "id": "#did-communication",
                                "type": "did-communication",
                                "serviceEndpoint": "https://bar.example.com"
                                },
                                {
                                "id": "#DIDComm",
                                "type": "DIDComm",
                                "serviceEndpoint": "https://bar.example.com"
                                }
                            ]
                        })

    url = url_base+'/v1/dids?tenantId='+issuer_id
    return requests.post(url, headers=headers, data=payload, timeout=60)


def post_schemas(url_base, 
                issuer_id,
                issuer_did,
                schema_name,
                payload=None, 
                header={'Content-Type': 'application/json'}):
    
    url = url_base+'/v1/schemas?tenantId='+issuer_id

    if payload is None:
        payload = json.dumps({
        "issuerDid": str(issuer_did),
        "name": schema_name,
        "version": "1.0.0",
        "attributeNames": [
            "height",
            "weight",
            "age"
        ]
    })
        
    return requests.post(url, headers=header, data=payload, timeout=60)


def get_schemas(url_base,
               issuer_id,
               payload = {},
               headers = {}):
    
    url = url_base+'/v1/schemas?tenantId='+issuer_id

    return requests.get(url, headers=headers, data=payload, timeout=60)


def post_credential_definition(url_base,
                               issuer_id,
                               issuer_did,
                               schema_id,
                               header={'Content-Type': 'application/json'},
                               supportsRevocation=False):
    
    url = url_base +'/v1/credential-definitions?tenantId='+issuer_id
    payload = json.dumps({
        "issuerDid": issuer_did,
        "schemaId": schema_id,
        "tag": "default",
        "supportsRevocation": supportsRevocation
    })

    return requests.post(url, headers=header, data=payload, timeout=60)


def list_credential_definitions(url_base,
                               issuer_id):
    url = url_base +'/v1/credential-definitions?tenantId='+issuer_id
    
    payload = {}
    headers = {}

    return requests.get(url, headers=headers, data=payload, timeout=60)


def create_invitation(url_base,
                      tenant_id):
    url = url_base + '/v1/invitations?tenantId='+tenant_id

    payload = {}
    headers = {
        'Content-Type': 'application/json'
    }

    return requests.post(url, headers=headers, data=payload, timeout=60)


def create_connection_to_self(url_base,
                              tenant_id):
    url = url_base + '/v1/connections?tenantId='+tenant_id

    payload = {}
    headers = {}

    return requests.post(url, headers=headers, data=payload, timeout=60)


def get_connection_id(url_base,
                      tenant_id):
    url = url_base + '/v1/connections?tenantId='+tenant_id

    payload = {}
    headers = {}

    time.sleep(1)
    return requests.get(url, headers=headers, data=payload, timeout=60)


def receive_invitation(url_base,
                       tenant_id,
                       invitation_url 
                       ):
    url = url_base + '/v1/invitations/receive?tenantId='+tenant_id

    payload = json.dumps({
        "invitationUrl": invitation_url
    })

    headers = {
        'Content-Type': 'application/json'
    }

    return requests.post(url, headers=headers, data=payload, timeout=60)

    
def get_tenant_holder_connection_id_for_tenant(url_base, tenant_id):
    get_id_response = get_connection_id(url_base, tenant_id)
    
    return get_id_response.json()["data"][0]["id"]    

def make_credential_offer(url_base, 
                          tenant_id, 
                          connection_id, 
                          credential_definition_id, 
                          payload=None):
    url = url_base+ "/v1/credential-offers?tenantId=" + tenant_id

    if payload is None:
        payload = json.dumps({
            "connectionId": connection_id,
            "credentialDefinitionId": credential_definition_id,
            "attributes": [
                {
                "name": "height",
                "value": "190 cm"
                },
                {
                "name": "weight",
                "value": "85 kg"
                },
                {
                "name": "age",
                "value": "40"
                }
            ]
        })
    
    headers = {
    'Content-Type': 'application/json'
    }

    return requests.post(url, headers=headers, data=payload, timeout=60)


def make_credential_offer_with_revocation(url_base, 
                          tenant_id, 
                          connection_id, 
                          credential_definition_id, 
                          revocation_registry_definition_id,
                          payload=None):
    url = url_base+ "/v1/credential-offers?tenantId=" + tenant_id

    if payload is None:
        payload = json.dumps({
            "connectionId": connection_id,
            "credentialDefinitionId": credential_definition_id,
            "revocationRegistryDefinitionId": revocation_registry_definition_id,
            "attributes": [
                {
                "name": "height",
                "value": "190 cm"
                },
                {
                "name": "weight",
                "value": "85 kg"
                },
                {
                "name": "age",
                "value": "40"
                }
            ]
        })
    
    headers = {
    'Content-Type': 'application/json'
    }

    return requests.post(url, headers=headers, data=payload, timeout=60)

def get_credential_offer(url_base, 
                         tenant_id):
    
    url = url_base + "/v1/credential-offers?tenantId=" + tenant_id

    payload = {}
    headers = {}

    time.sleep(1)
    response = requests.get(url, headers=headers, data=payload, timeout=60)
    return response.json()["data"][0]["id"]

def accept_credential_offer(url_base, 
                         tenant_id,
                         holder_credential_offer_id):
    
    url = url_base + "/v1/credential-offers/" + holder_credential_offer_id + "/accept?tenantId=" + tenant_id

    payload = {}
    headers = {}

    return requests.post(url, headers=headers, data=payload, timeout=60)

def get_credentials(url_base, 
                         tenant_id):
    url = url_base + "/v1/credentials?tenantId=" + tenant_id

    payload = {}
    headers = {}

    return requests.get(url, headers=headers, data=payload, timeout=60)

def create_credential_offer_to_self(url_base, 
                                    tenant_id,  
                                    credential_definition_id, 
                                    payload=None):
    url = url_base+ "/v1/credential-offers/self?tenantId=" + tenant_id

    if payload is None:
        payload = json.dumps({
            "credentialDefinitionId": credential_definition_id,
            "attributes": [
                {
                "name": "height",
                "value": "190 cm"
                },
                {
                "name": "weight",
                "value": "85 kg"
                },
                {
                "name": "age",
                "value": "40"
                }
            ]
        })

    headers = {
    'Content-Type': 'application/json'
    }

    return requests.post(url, headers=headers, data=payload, timeout=60)

def request_credential_proof(url_base, 
                             tenant_id,
                             connection_id):
    

    url = url_base+ "/v1/proofs?tenantId="+tenant_id

    payload = json.dumps({
        "name": generate_random_business_name(),
        "connectionId": connection_id,
        "requestedAttributes": {
            "height": {
                "names": [
                    "height"
                ]
            },
            "weight": {
                "names": [
                    "weight"
                ]
            },
            "age": {
                "names": [
                    "age"
                ]
            }
        },
        "requestedPredicates": {}
    })

    headers = {
    'Content-Type': 'application/json'
    }

    return requests.post(url, headers=headers, data=payload, timeout=60)

def get_tenant_proof_request(url_base,
                             tenant_id):
    
    url = url_base+ "/v1/proofs?tenantId="+tenant_id

    payload = {}
    headers = {}

    time.sleep(1)
    return requests.get(url, headers=headers, data=payload, timeout=60)

def accept_proof_request(url_base,
                         tenant_id,
                         proof_record_id):
    
    url = url_base + "/v1/proofs/" + proof_record_id + "/accept?tenantId=" + tenant_id

    payload = {}
    headers = {}

    return requests.post(url, headers=headers, data=payload, timeout=60)

def revoke_credential(url_base,
                      tenant_id,
                      credential_id):
    url = url_base + "/v1/credentials/" + credential_id + "/revoke?tenantId=" + tenant_id

    payload = {}
    headers = {}

    return requests.post(url, headers=headers, data=payload, timeout=60)