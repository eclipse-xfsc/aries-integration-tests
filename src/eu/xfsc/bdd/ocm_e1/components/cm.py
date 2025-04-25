"""Didcomm Connector"""
import pydantic
import requests

from eu.xfsc.bdd.core.server import BaseService


class CM(BaseService):
    """
    Repos:
    - current: https://gitlab.eclipse.org/eclipse/xfsc/common-services/didcomm-connector
    - legacy: https://gitlab.eclipse.org/eclipse/xfsc/ocm/ocm-engine/-/tree/main/apps/connection-manager
    """
    host: pydantic.HttpUrl

    def is_up(self) -> bool:
        print(f"HTTP GET {self.host}/health")
        # /health ?
        return True

    def request(self, connection_id: str) -> requests.Response:
        print(f'GET request with connection_id {self.host}/request/{connection_id}')
        response = requests.Response()
        response.status_code = 200
        return response

    def marked_as_blocked(self, connection_id: str) -> bool:
        print(f'GET request with connection_id {self.host}/marked/{connection_id}')
        return True
