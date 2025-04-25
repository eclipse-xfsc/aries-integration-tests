#Copyright (c) 2018 Vereign AG [https://www.vereign.com]
#
#This is free software: you can redistribute it and/or modify
#it under the terms of the GNU Affero General Public License as
#published by the Free Software Foundation, either version 3 of the
#License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU Affero General Public License for more details.
#
#You should have received a copy of the GNU Affero General Public License
#along with this program. If not, see <http://www.gnu.org/licenses/>.

#http://localhost/ocm/attestation/v1/credentialDef?schemaID=:schemaID
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - credentialDef - :schemaID GET
  This request fetches the created credentials against provided schema_id.
  It uses pagination to provide the particular number of records filtered as per the input given.

  Background:
    Given we are testing the OCM Api

  @cred
  Scenario: OCM - Attestation - Get credentialDef with SchemaID - Positive
  #Creation of the schema
    Given I load the REST request {AttestationCreateSchemas.json} with profile {successful_creation}
    Then I create a new schema with random version via Attestation Manager in OCM api
    And the status code should be {201}
  #Creation of the Credential definition
    And I clear the request body
    Given I load the REST request {AttestationCreateCredentialDef.json} with profile {successful_creation}
    Then I create a new credential definition with the current schemaId via OCM Api
    And the status code should be {201}
  #Get Credential Definitions via SchemaID
    And I clear the request body
    Given I get a credential definition with the current schemaID via OCM Api
    And the status code should be {200}
    And the response is valid according to the {Attestation_GET_credentialDef.json} REST schema
    Then the field {statusCode} contains the value {200}
    Then the field {message} contains the value {Credential definitions fetch successfully}
    Then the field {$..name} contains the value {Automation_CredDef_001}
    Then the field {$.data.count} contains the value {1}
    Then the field {$.data.records} contains the value {1}

  @cred
  Scenario: OCM - Attestation - Create 2 Credential Def with the same Schema and then GET it - Positive
  #Creation of the schema
    Given I load the REST request {AttestationCreateSchemas.json} with profile {successful_creation}
    Then I create a new schema with random version via Attestation Manager in OCM api
    And the status code should be {201}
  #Creation of the Credential definition
    And I clear the request body
    Given I load the REST request {AttestationCreateCredentialDef.json} with profile {successful_creation}
    Then I create a new credential definition with the current schemaId via OCM Api
    And the status code should be {201}
  #Creation of 2nd Credential definition with the same schemaID
    Given I set the request fields
      | name | Automation_CredDef_002 |
    Then I create a new credential definition via OCM Api
    And the status code should be {201}
  #Get Credential Definitions via SchemaID
    And I clear the request body
    Given I get a credential definition with the current schemaID via OCM Api
    And the status code should be {200}
    And the response is valid according to the {Attestation_GET_credentialDef.json} REST schema
    Then the field {statusCode} contains the value {200}
    Then the field {message} contains the value {Credential definitions fetch successfully}
    Then the field {$.data.count} contains the value {2}
    Then the field {$..name} contains the value {Automation_CredDef_001}
    Then the field {$..name} contains the value {Automation_CredDef_002}
    Then the field {$.data.records} contains the value {2}

  @cred @negative
  Scenario: OCM - Attestation - Try to get Credential Definition with non existant schemaID- Negative
    Given I get a credential definition with schemaID {test1234} via OCM Api
    Then the field {statusCode} contains the value {404}
    And the status code should be {404}
    Then the field {message} contains the value {No Data found}