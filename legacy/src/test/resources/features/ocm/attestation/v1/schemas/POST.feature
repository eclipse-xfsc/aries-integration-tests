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

#http://localhost/ocm/attestation/v1/schemas
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - schemas POST
  It is used to create schema.
  The schema is a template which defines the schema name,
  version and the attributes and is used to define the credential definition.


  Background:
    Given we are testing the OCM Api

  @schemas
  Scenario: OCM - Attestation - Creation of a new Schema with attributes - Positive
    Given I load the REST request {AttestationCreateSchemas.json} with profile {successful_creation}
    Then I create a new schema with random version via Attestation Manager in OCM api
    Then the field {statusCode} contains the value {201}
    And the status code should be {201}
    And the response is valid according to the {Attestation_POST_schemas.json} REST schema
    And the field {message} contains the value {Schema created successfully}
    And the field {$..name} contains the value {automation_testing_schema1-01}
    And the value {$.version} in the request contains the value {$..schemaID} of the response
    And the value {$.name} in the request contains the value {$..schemaID} of the response
    And the field {$..attribute..name} contains the value {fName}
    And the field {$..attribute..name} contains the value {lName}
    And the field {$..attribute..name} contains the value {gender}
    And the field {$..attribute..name} contains the value {expirationDate}

  @schemas @negative
  Scenario: OCM - Attestation - Try to create a new schema with existing version - Negative
    Given I load the REST request {AttestationCreateSchemas.json} with profile {successful_creation}
    Then I create a new schema with random version via Attestation Manager in OCM api
    Then the field {statusCode} contains the value {201}
    And the status code should be {201}
    Given I create a new schema via Attestation Manager in OCM api
    And the status code should be {409}
    And the field {statusCode} contains the value {409}
    And the field {message} contains the value {Schema already exists}

  @schemas @negative
  Scenario Outline: OCM - Attestation - Try to create a new schema with invalid data <json> - Negative
    Given I load the REST request {AttestationCreateSchemas.json} with profile {<json>}
    Then I create a new schema with random version via Attestation Manager in OCM api
    Then the field {statusCode} contains the value {400}
    And the status code should be {400}
    And the field {message} contains the value {Schema required following attributes ( name, createdBy, version, attributes )}
    Examples:
      | json               |
      | missing_name       |
      | missing_attributes |
      | missing_createdBy  |
      | empty_name         |
      | empty_attributes   |
      | empty_createdBy    |

  @schemas @negative
  Scenario Outline: OCM - Attestation - Try to create a new schema with invalid version <json> - Negative
    Given I load the REST request {AttestationCreateSchemas.json} with profile {<json>}
    Then I create a new schema via Attestation Manager in OCM api
    Then the field {statusCode} contains the value {400}
    And the status code should be {400}
    And the field {message} contains the value {Schema required following attributes ( name, createdBy, version, attributes )}
    Examples:
      | json                 |
      | empty_version        |
      | missing_version      |
      | wrong_format_version |