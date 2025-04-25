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

#http://localhost/ocm/attestation/v1/credentialDef
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - credentialDef POST
  It is used to create the Credential Definition.
  A credential definition is a particular issuer's template based on an existing schema to issue credentials from.


  Background:
    Given we are testing the OCM Api

  @cred
  Scenario: OCM - Attestation - Creation of credential definition based on a newly created schema - Positive
  #Creation of the schema
    Given I load the REST request {AttestationCreateSchemas.json} with profile {successful_creation}
    Then I create a new schema with random version via Attestation Manager in OCM api
    Then the field {statusCode} contains the value {201}
    And the status code should be {201}
  #Creation of the Credential definition
    And I clear the request body
    Given I load the REST request {AttestationCreateCredentialDef.json} with profile {successful_creation}
    Then I create a new credential definition with the current schemaId via OCM Api
    And the status code should be {201}
    And the response is valid according to the {Attestation_POST_credentialDef.json} REST schema
    And the field {message} contains the value {Credential definition created successfully}
    And the field {statusCode} contains the value {201}
    And the field {$.data.name} contains the value {Automation_CredDef_001}
    And the field {$.data.isAutoIssue} contains the value {false}
    And the field {$.data.isRevokable} contains the value {false}
    And the field {$.data.expiryHours} contains the value {24}

  @cred @negative
  Scenario Outline: OCM - Attestation - Try to create a credential def with invalid data <json> - Negative
    Given I load the REST request {AttestationCreateCredentialDef.json} with profile {<json>}
    Then I create a new credential definition via OCM Api
    And the status code should be {400}
    And the field {message} contains the value {Credential definition required following attributes ( schemaID, name, isRevokable, isAutoIssue, createdBy, expiryHours )}
    And the field {statusCode} contains the value {400}
    Examples:
      | json                |
      | missing_name        |
      | missing_isRevokable |
      | missing_isAutoIssue |
      | missing_createdBy   |
      | missing_schemaID    |
      | missing_expiryHours |
      | empty_name          |
      | empty_schemaID      |
      | empty_createdBy     |
      | empty_expiryHours   |

  @cred @negative
  Scenario: OCM - Attestation - Try to create 2nd credential def with the same SchemaID and same name - Negative
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
    Then I create a new credential definition via OCM Api
    And the status code should be {409}
    And the field {statusCode} contains the value {409}
    And the field {message} contains the value {Credential definition already exists}

  @cred
  Scenario: OCM - Attestation - Create a second Credential Definition under the same schema with different name - Positive
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
    And the response is valid according to the {Attestation_POST_credentialDef.json} REST schema
    And the field {message} contains the value {Credential definition created successfully}
    And the field {statusCode} contains the value {201}
    And the field {$.data.name} contains the value {Automation_CredDef_002}
    And the field {$.data.isAutoIssue} contains the value {false}
    And the field {$.data.isRevokable} contains the value {false}
    And the field {$.data.expiryHours} contains the value {24}
