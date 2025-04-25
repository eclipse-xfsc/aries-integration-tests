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

#http://localhost/ocm/attestation/v1/credentialDef/:credentialDef
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - credentialDef - :credentialDefId GET
  This request is used to fetch credential definitions for the provided cred_def_id in URL.

  Background:
    Given we are testing the OCM Api

  @cred
  Scenario: OCM - Attestation - Get the newly created CredentialDef - Positive
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
  #Get the newly created Credential Definition
    And I clear the request body
    Then I get current Credential definition via OCM API
    And the status code should be {200}
    And the field {statusCode} contains the value {200}
    And the response is valid according to the {Attestation_GET_credentialDef.json} REST schema

  @cred @negative
  Scenario: OCM - Attestation - Try to get a credential def with invalid id - Positive
    Then I get a credential definition with credDefId {invalidCredDefId} via OCM Api
    And the status code should be {404}
    And the field {statusCode} contains the value {404}
    And the field {message} contains the value {No Data found}