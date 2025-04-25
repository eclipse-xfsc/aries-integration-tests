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

#http://localhost/ocm/attestation/v1/schemas/:schemaID
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - schemas - :schemaID GET
  This request fetches specific schema via SchemaID

  Background:
    Given we are testing the OCM Api

  @schemas
  Scenario: OCM - Attestation - Getting schema with schemaID - Positive
    Given I load the REST request {AttestationCreateSchemas.json} with profile {successful_creation}
    Then I create a new schema with random version via Attestation Manager in OCM api
    And the status code should be {201}
   #Get the current Schema via SchemaID
    Given I get the current Schema via OCM api
    Then the field {statusCode} contains the value {200}
    And the status code should be {200}
    And the response is valid according to the {Attestation_GET_schemas.json} REST schema
    And the field {message} contains the value {Schema fetch successfully}
    And the field {$.data.count} contains the value {1}

  @schemas @negative
  Scenario: OCM - Attestation -  Try to get schema by providing invalid schemaID - Positive
    Given I get schema with schemaID {test12313} via OCM Api
    Then the field {statusCode} contains the value {404}
    And the status code should be {404}
    And the field {message} contains the value {No Data found}