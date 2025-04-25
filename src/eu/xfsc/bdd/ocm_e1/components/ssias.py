"""SSI Abstraction Service"""
import pydantic

from eu.xfsc.bdd.core.server import BaseService


class SSIAS(BaseService):
    """
    Stack: TypeScript Server
    Repo: https://gitlab.eclipse.org/eclipse/xfsc/ocm/ocm-engine/-/tree/main/apps/ssi-abstraction
    """
    host: pydantic.HttpUrl

    def is_up(self) -> bool:
        print(f"HTTP GET {self.host}/health")
        # /health ?
        return True

    def is_deleted(self, input_connection_id: str) -> bool:
        print(f'GET request with input_connection_id {self.host}/deleted/{input_connection_id}')
        return True
