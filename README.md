# Moved

https://github.com/eclipse-xfsc/aries-integration-tests

# ocm-bdd-2-qa



## Quick Install

Clone this repo, run the following commands

```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Set Up Test Environment

Clone the OCM Engine Repo:

```
git clone https://gitlab.eclipse.org/eclipse/xfsc/ocm/ocm-engine/
```

Check the postman collection from that repo:
`/ocm-engine/documentation/Gaia-X Organization Credential Manager.postman_collection.json`

and run the following commands:

```
sudo docker compose build ssi-abstraction 
sudo docker compose up -d --build schema-manager 
sudo docker compose up -d --build credential-manager 
sudo docker compose up -d 
```

and also run

```
sudo docker network create -d bridge test_network 
```

### Set up two OCM Engine Services for e2e connection tests

Run `sudo docker compose down -v --remove-orphans `

then run these commands (on 3 different terminal windows):
```
sudo docker compose -f docker-compose.yml up
```
```
sudo docker compose -f docker-compose-2.yml up
```
```
sudo docker compose -f docker-compose-3.yml up
```


## Run Tests
If not within the python virtual env, run `source venv/bin/activate`

To execute tests, run 
```
behave features
```

## Save new packages

```
pip freeze > requirements.txt
```


## Generate test reports

For HTML report, run
```
behave -f html-pretty -o behave-report.html
```

Fot simple text report 
```
behave -f pretty -o report.txt
```

See test report here
