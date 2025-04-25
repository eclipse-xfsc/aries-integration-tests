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

#http://localhost/ocm/attestation/v1/accept-request?credentialId=:credentialDef
#Author: Rosen Georgiev rosen.georgiev@vereign.com
#NOTE: Cannot be tested without PCM to receive an Credential Offer

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - accept-request POST
  It is used to accept the acknowledgement received from another Aries agent
  for the issuance for Verifiable Credential and send Verifiable Credential.

  Background:
    Given we are testing the OCM Api

  @cred @wip
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
  #Trying to accept a newly created Credential Def without being offered and approved by PCM
    And I clear the request body
    Given I accept request for the current credentialId via OCM Api
    And the status code should be {201}