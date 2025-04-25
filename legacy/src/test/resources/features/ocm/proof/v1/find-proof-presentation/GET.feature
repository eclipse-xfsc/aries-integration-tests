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

#http://localhost/ocm/proof/v1/find-proof-presentation
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @proof
Feature: API - OCM - proof - v1 - find-proof-presentation GET
  This request fetches the all the proof presentation requests for the participant.
  The records can be filtered using provided query parameters.

  Background:
    Given we are testing the OCM Api

  @proof
  Scenario: OCM - Proof - Get all Proof Presentations - Positive
    Given I get all proof presentations via OCM Api
    Then the field {statusCode} contains the value {200}
    And the status code should be {200}
    Then the field {message} contains the value {Proof presentations fetched successfully}
    And the response is valid according to the {Proof_GET_find_proof_presentation.json} REST schema

  @proof
  Scenario: OCM - Proof - Get all Proof Presentations with pagination - Positive
    Given I get all proof presentations with pageSize {5} and page {0} via OCM api
    Then the field {statusCode} contains the value {200}
    And the status code should be {200}
    Then the field {message} contains the value {Proof presentations fetched successfully}
    And the response is valid according to the {Proof_GET_find_proof_presentation.json} REST schema
    And the field {$.data.records} contains {5} elements

  @proof @negative
  Scenario: OCM - Proof - Try to get presentations with out of bounds pagination - Negative
    Given I get all proof presentations with pageSize {9999} and page {999} via OCM api
    Then the field {statusCode} contains the value {200}
    And the status code should be {200}
    Then the field {message} contains the value {Proof presentations fetched successfully}
    And the response is valid according to the {Proof_GET_find_proof_presentation.json} REST schema
    And the field {$.data.records} contains {0} elements