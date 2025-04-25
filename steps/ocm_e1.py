from eu.xfsc.bdd.core.steps import *

from typing import Any, Optional

from behave import then, given, when
import requests


from eu.xfsc.bdd.ocm_e1.components.cm import CM
from eu.xfsc.bdd.ocm_e1.components.ssias import SSIAS


class ContextType:
    requests_response: requests.Response
    text: str
    input_connection_id: str
    cm: CM
    ssias: SSIAS


@given("input connection ID `{connection_id}` provided")
def add_did(context: ContextType, connection_id: str) -> None:
    context.input_connection_id = connection_id


@given("that CM is running")
def check_cm_running(context: ContextType) -> None:
    context.cm = CM(host='http://localhost:1235')  # type: ignore[arg-type]
    assert context.cm.is_up(), "is not up"


@given("that SSIAS is running")
def check_ssias_running(context: ContextType) -> None:
    context.ssias = SSIAS(host='http://localhost:1236')  # type: ignore[arg-type]
    assert context.ssias.is_up(), "is not up"


@when("a request to CM is made")
def run_cm_request(context: ContextType) -> None:
    context.requests_response = context.cm.request(context.input_connection_id)


@then("the connection is deleted from SSIAS")
def check_ssias_connection_id_deleted(context: ContextType) -> None:
    assert context.ssias.is_deleted(context.input_connection_id)


@then("the connection is marked as blocked in CM")
def check_cm_connection_id_marked_deleted(context: ContextType) -> None:
    assert context.cm.marked_as_blocked(context.input_connection_id)
