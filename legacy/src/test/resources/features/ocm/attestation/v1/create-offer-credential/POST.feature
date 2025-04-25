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

#http://localhost/ocm/attestation/v1/create-offer-credential
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - create-offer-credential POST
  A message sent by the Issuer to the potential Holder, describing the credential they intend to offer.

  In Hyperledger Indy, this message is required, because it forces the Issuer to make a cryptographic commitment to the set of
  fields in the final credential and thus prevents Issuers from inserting spurious data.


  Background:
    Given we are testing the OCM Api

  @cred @negative
  Scenario: OCM - Attestation - Try to Create offer of the currently created credential for untrusted connection - Negative
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
  #Create offer credential
    And I clear the request body
    Given I load the REST request {AttestationCreateOfferDef.json} with profile {successful_creation}
    Given I create an offer credential for the current Connection and Schema via OCM Api
    And the status code should be {400}
    Then the field {statusCode} contains the value {400}
    Then the field {message} contains the value {Connection is not trusted}

  @cred @negative
  Scenario Outline: OCM - Attestation - Try to Create offer of the currently created credential with invalid connectionid <connId> - Negative
  #Create a new member process connection
    Given an administrator generates a QR code by creating a connection with alias {member} via OCM api
    Then the field {statusCode} contains the value {200}
    And the status code should be {201}
  #Creation of the schema
    And I clear the request body
    Given I load the REST request {AttestationCreateSchemas.json} with profile {successful_creation}
    Then I create a new schema with random version via Attestation Manager in OCM api
    And the status code should be {201}
  #Creation of the Credential definition
    And I clear the request body
    Given I load the REST request {AttestationCreateCredentialDef.json} with profile {successful_creation}
    Then I create a new credential definition with the current schemaId via OCM Api
    And the status code should be {201}
  #Create offer credential
    And I clear the request body
    Given I load the REST request {AttestationCreateOfferDef.json} with profile {successful_creation}
    Given I create an offer credential with connectionId {<connId>} via OCM Api
    And the status code should be {400}
    Then the field {statusCode} contains the value {<status>}
    Then the field {message} contains the value {<msg>}
    Examples:
      | connId    | status | msg                                                                                                                       |
      |           | 400    | Offer credentials required following attributes ( connectionId, credentialDefinitionId, attributes, autoAcceptCredential) |