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

#http://localhost/ocm/attestation/v1/delete-credential/:credentialId
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @attestation
Feature: API - OCM - attestation - v1 - delete-credential- :credentialId DELETE
  This request deletes credential

  Background:
    Given we are testing the OCM Api

  @delete-credential @negative
  Scenario: OCM - Attestation - Try to Delete Credential with invalid id - Negative
    Given I delete credential with credentialId {343585a2-ced4-44ff-9567-974313d2175d}  via OCM api
    And the status code should be {500}
    And the field {statusCode} contains the value {500}
    And the field {message} contains the value {Request failed with status code 404}
