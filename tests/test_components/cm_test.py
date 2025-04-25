# pylint: disable=missing-module-docstring
from eu.xfsc.bdd.ocm_e1.components.cm import CM


def test_request():
    """
    GIVEN Didcomm Connector setup
    WHEN request a didcomm connector with connection_id
    THEN get http 200:ok code
    """
    cm = CM(host='https://some_value')
    response = cm.request('some_content_id')
    assert response.status_code == 200
