# OCM-E1 (Organisational Credential Manager Extension 1) Behaviour-driven development (BDD) framework

Based on XFSC Python based BDD lib [eu.xfsc.bdd.core].

# Description

CI Automation (Setup, Run and Reports) is set up with Jenkins.
Here's the pipeline visualization from the [Jenkinsfile](Jenkinsfile) `OCM-E1` pipeline:

![Jenkins-pipeline-visualisation-for-bdd.ocm-1.png](docs/Jenkins-pipeline-visualisation-for-bdd.ocm-e1.png)

The components' relationship is drawn in Plant UML syntax below.

```plantuml
@startuml

actor :User:
actor :Developer:
actor :Jenkins:

component "Didcomm Connector" as CM
component "Block Connection Endpoint" as BCM
component "SSI Abstraction Service" as SSIAS


package "BDD:repo eu.xfsc.bdd.ocm_e1" {
  component Features
  component Steps
}


Jenkins    --|> User
Developer  --|> User
User       -up->  Features: execute

Steps -->  CM
CM    --> BCM
CM    --> SSIAS 
@enduml
```

# Getting started

## Requirements

* Clone

  ```bash
  git clone git@gitlab.eclipse.org:eclipse/xfsc/ocm/bdd.git \
    -b optional-branch-name-if-not-main
  
  git clone git@gitlab.eclipse.org:eclipse/xfsc/dev-ops/testing/bdd-executor.git \
    -b optional-branch-name-if-not-main
  ```

* Docker Engine (Docker Desktop, Podman machine, Rancher ...)
* For macOS or Linux, we provide below instructions on how to set up.
* For Windows, we recommend a dockerized setup or a remote (ssh) Linux dev server.

## Setup

For setup, look into [eu.xfsc.bdd.core/README.md].

## Run

### 1. Start all required services.

TBA

```bash
$ make TBA
```

TBA: Start Component as Docker container

> **_HINT:_** Ensure on macOS to start Docker Engine (Desktop Docker, Podman machine or Rancher)
before running the below command.

```bash
# Start component and leave it running as a process
$ make TBA
```

### 2. Execute BDD features [features](features)

```bash   
make run_bdd_dev
```

## License

Apache License Version 2.0 see [LICENSE](LICENSE).

----------------------------------------------------------------------------------

[eu.xfsc.bdd.core]: https://gitlab.eclipse.org/eclipse/xfsc/dev-ops/testing/bdd-executor
[eu.xfsc.bdd.core/README.md]: https://gitlab.eclipse.org/eclipse/xfsc/dev-ops/testing/bdd-executor/-/blob/main/README.md?ref_type=heads#setup 