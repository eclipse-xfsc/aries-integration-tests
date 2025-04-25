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

#http://localhost/ocm/connection/v1/connections
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @connection
Feature: API - OCM - connection - v1 - connections GET
  This request fetches the connection information against the provided participantDID,
  otherwise all the connections are fetched.

  Background:
    Given we are testing the OCM Api

  @connections
  Scenario: OCM - GET all connections - Positive
    Given an administrator fetches all the connections via OCM api
    Then the field {statusCode} contains the value {200}
    And the response is valid according to the {Connection_GetConnections_schema.json} REST schema
    Then the field {message} contains the value {Connections fetch successfully}

  @connections
  Scenario: OCM - GET all connections with pagination - Positive
    Given an administrator fetches all the connections with pageSize {5} and page {0} via OCM api
    Then the field {statusCode} contains the value {200}
    And the response is valid according to the {Connection_GetConnections_schema.json} REST schema
    Then the field {message} contains the value {Connections fetch successfully}
    And the field {$.data.records} contains {5} elements

  @connections @negative
  Scenario: OCM - GET all connections with pagination out of bounds - negative
    Given an administrator fetches all the connections with pageSize {9999} and page {9999} via OCM api
    Then the field {statusCode} contains the value {200}
    And the response is valid according to the {Connection_GetConnections_schema.json} REST schema
    Then the field {message} contains the value {Connections fetch successfully}
    And the field {$.data.records} contains {0} elements