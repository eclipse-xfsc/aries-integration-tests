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

#http://localhost/ocm/attestation/v1/credential
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - credential GET
  This request fetches the issued verifiable credentials.
  It uses pagination to provide the particular number of records filtered as per the input given.

  Background:
    Given we are testing the OCM Api

  @cred
  Scenario: OCM - Attestation - Get all Credentials - Positive
    Then I get all credentials via OCM Api
    And the status code should be {200}
    And the field {statusCode} contains the value {200}
    And the field {message} contains the value {Credential fetch successfully}
    And the response is valid according to the {Attestation_GET_credential.json} REST schema

  @cred
  Scenario: OCM - Attestation - Get all Credentials with pagination without any records - Positive
    Then I get all credentials with pageSize {9999} and page {9999} via OCM api
    And the status code should be {200}
    And the field {statusCode} contains the value {200}
    And the field {message} contains the value {Credential fetch successfully}
    And the response is valid according to the {Attestation_GET_credential.json} REST schema
    And the field {$.data.records} contains {0} elements

  @cred
  Scenario: OCM - Attestation - Get all Credentials with pagination for just 5 records - Positive
    Then I get all credentials with pageSize {5} and page {0} via OCM api
    And the status code should be {200}
    And the field {statusCode} contains the value {200}
    And the field {message} contains the value {Credential fetch successfully}
    And the response is valid according to the {Attestation_GET_credential.json} REST schema
    And the field {$.data.records} contains {5} elements

  @cred @negative
  Scenario Outline: OCM - Attestation - Try to Get a credential with filter <filter> and value <value> - Negative
    Then I get specific credential with filter {<filter>} and value {<value>} via OCM api
    And the status code should be {<code>}
    And the field {message} contains the value {<msg>}
    And the field {statusCode} contains the value {<statusCode>}
    Examples:
      | filter              | value                                     | code | msg           | statusCode |
      | credDefId           | 8y8oycXjnQCRT2t3mRuzbP:3:CL:41034:test5.0 | 404  | No Data found | 404        |
      | state               | credential                                | 404  | No Data found | 404        |
      | createdDateStart    | 2029-03-28T12:09:56.739Z                  | 404  | No Data found | 404        |
      | createdDateEnd      | 2020-03-28T12:09:56.739Z                  | 404  | No Data found | 404        |
      | expirationDateStart | 2029-03-28T12:09:56.739Z                  | 404  | No Data found | 404        |
      | expirationDateEnd   | 2020-03-28T12:09:56.739Z                  | 404  | No Data found | 404        |
      | connectionId        | 2ewqeadasdadasda                          | 404  | No Data found | 404        |
      | principalDid        | 2ewqeadasdadasda                          | 404  | No Data found | 404        |
      | threadId            | 2ewqeadasdadasda                          | 404  | No Data found | 404        |

  @cred
  Scenario Outline: OCM - Attestation - Get a credential with filter <filter> - Positive
  #Get all credentials to choose 1 and get its data to be able to filter after that
    Given I get all credentials with pageSize {20} and page {0} via OCM api
    And the status code should be {200}
    Then I clear the query parameters
    Then I get the current credential with filter <filter> via OCM api
    And the status code should be {200}
    And the field {message} contains the value {Credential fetch successfully}
    Examples:
      | filter           |
      | credDefId        |
      | threadId         |
      | principalDid     |
      | connectionId     |
      | state            |
      | createdDateStart |