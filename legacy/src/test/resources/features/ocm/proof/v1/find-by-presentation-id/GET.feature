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

#http://localhost/ocm/proof/v1/find-by-presentation-id?proofRecordId={{proofRecordId}}
#Author: Rosen Georgiev rosen.georgiev@vereign.com

#NOTE: Cannot be fully tested, because it needs connection to be made with PCM.

@rest @all @ocm @proof
Feature: API - OCM - proof - v1 - find-by-presentation-id GET
  This request is used to fetch proof presentation request information for the presentation id provided in query parameter.
  It also provides state of the proof presentation request.



  Background:
    Given we are testing the OCM Api

  @presentation @negative
  Scenario: OCM - Proof - Get proof presentation with proofRecordId - Positive
    Given I get proof presentations with proofRecordId {nonExistentId} via OCM Api
    Then the field {statusCode} contains the value {404}
    And the status code should be {404}
    Then the field {message} contains the value {proof with proofRecordId "nonExistentId" not found.}

  @proof @bug-proof-25 @bug-proof-24
  Scenario: OCM - Proof - Get OOB presentation request via proofRecordId - Positive
  #Create a new member process connection
    Given an administrator generates a QR code by creating a connection with alias {member} via OCM api
    Then the field {statusCode} contains the value {200}
    And the status code should be {201}
  #Creation of the schema
    And I clear the query parameters
    And I clear the request body
    Given I load the REST request {AttestationCreateSchemas.json} with profile {successful_creation}
    Then I create a new schema with random version via Attestation Manager in OCM api
    And the status code should be {201}
  #Creation of the Credential definition
    And I clear the request body
    Given I load the REST request {AttestationCreateCredentialDef.json} with profile {successful_creation}
    Then I create a new credential definition with the current schemaId via OCM Api
    And the status code should be {201}
    And I clear the request body
  #Send Out of Bound Presentation Request
    Given I load the REST request {ProofSendOOBPresentationRequest.json} with profile {successful_creation}
    Then I send out of bound presentation request with the current data via OCM Api
    And the status code should be {201}
    Then the field {statusCode} contains the value {201}
  #Get the request via proofRecordId
    And I clear the request body
    Given I get proof presentations with the current proofRecordId via OCM Api
    Then the field {statusCode} contains the value {200}
    And the status code should be {200}
    Then the field {message} contains the value {Proof presentation fetched successfully}
    Then the field {$.data.state} contains the value {request-sent}