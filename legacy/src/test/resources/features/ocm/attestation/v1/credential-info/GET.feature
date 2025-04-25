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

#http://localhost/ocm/attestation/v1/credential-info/:credentialId
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - credential-info - :credentialId GET
  This request fetches the issued verifiable credential-info.

  Background:
    Given we are testing the OCM Api

  @credential-info
  Scenario: OCM - Attestation - Get Credential-info - Positive
  #Get all credentials to get a specific credentialId to fetch the additional information of it
    Given I get all credentials via OCM Api
    And the status code should be {200}
    Then I clear the query parameters
    And I get the current credential-info via OCM api
    And the status code should be {200}
    And the field {statusCode} contains the value {200}
    And the field {message} contains the value {Agent responded}

 #should be fixed in the future error handling refactoring
  @credential-info @negative
  Scenario: OCM - Attestation - Try to Get Credential-info for nonexisting credentialId - Negative
    And I get credential-info with credentialId {nonExisting} via OCM api
    And the status code should be {500}
    And the field {statusCode} contains the value {500}
    And the field {message} contains the value {Request failed with status code 404}