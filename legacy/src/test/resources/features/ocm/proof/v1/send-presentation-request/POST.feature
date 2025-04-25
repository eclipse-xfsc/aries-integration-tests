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

#http://localhost/ocm/attestation/v1/send-presentation-request
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm
Feature: API - OCM - proof - v1 - send-presentation-request POST
  From a verifier to a prover, the presentation request message describes values
  that need to be revealed and predicates that need to be fulfilled.

  In Hyperledger Indy, this message is required, because it forces the Issuer to make a cryptographic commitment
  to the set of fields in the final credential and thus prevents Issuers from inserting spurious data.

  NOTE: This request needs PCM to be able to be properly tested

  Background:
    Given we are testing the OCM Api

  @proof
  Scenario: OCM - Proof - Try to Create offer of the currently created credential for untrusted connection - Negative
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
  #Send Presentation Request
    Given I load the REST request {ProofSendPresentationRequest.json} with profile {successful_creation}
    Then I send presentation request with the current data via OCM Api
    And the status code should be {400}
    Then the field {statusCode} contains the value {400}
    Then the field {message} contains the value {Could not get schema or connection details. please try again.}

