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

#http://localhost/ocm/attestation/v1/send-out-of-band-presentation-request
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm
Feature: API - OCM - proof - v1 - send-out-of-band-presentation-request POST
  From a verifier to a prover, the out of band presentation request message describes values
  that need to be revealed and predicates that need to be fulfilled.

  The Out-of-band protocol is used when you wish to engage with another
  agent and you don't have a DIDComm connection to use for the interaction.

  NOTE: This request needs PCM to be able to be called

  Background:
    Given we are testing the OCM Api

  @proof @bug-proof-25 @bug-proof-24
  Scenario: OCM - Proof - Create out of bounds presentation - Positive
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
    Then the field {message} contains the value {Presentation request sent successfully}
    Then the field {$.data.credentialDefId} contains the value {}
    Then the field {$.data.status} contains the value {request-sent}
    And the response is valid according to the {Proof_POST_OOB_presentation_request.json} REST schema

  @proof @bug-proof-25 @bug-proof-24
  Scenario Outline: OCM - Proof - Try to Create out of bounds presentation with <profile> - Negative
  #Send Out of Bound Presentation Request
    Given I load the REST request {ProofSendOOBPresentationRequest.json} with profile {<profile>}
    Then I send out of bound presentation request via OCM Api
    And the status code should be {201}
    Then the field {statusCode} contains the value {201}
    Then the field {message} contains the value {Presentation request sent successfully}
    Then the field {$.data.credentialDefId} contains the value {}
    Then the field {$.data.status} contains the value {request-sent}
    And the response is valid according to the {Proof_POST_OOB_presentation_request.json} REST schema
    Examples:
      | profile               |
      | empty_schemaID        |
      | empty_credentialDefId |
      | empty_connectionId    |