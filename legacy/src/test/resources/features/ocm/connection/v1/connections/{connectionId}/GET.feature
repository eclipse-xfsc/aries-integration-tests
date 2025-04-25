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

#http://localhost/ocm/connection/v1/connections/{connectionId}
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @connection
Feature: API - OCM - connection - v1 - connections - connectionId GET
  This request is used to fetch connection information for the connection id provided in URL.
  It also provides state of the connection established.

  Background:
    Given we are testing the OCM Api

  @connection
  Scenario: OCM - Creating a new process connection with alias <alias>- Positive
#Create a new member process connection
    Given an administrator generates a QR code by creating a connection with alias {member} via OCM api
    Then the field {statusCode} contains the value {200}
    And the status code should be {201}
#Get the current Connection
    Given an administrator fetches the current connection via OCM Api
    Then the field {statusCode} contains the value {200}
    And the status code should be {200}
    Then the field {message} contains the value {Connections fetch successfully}
    Then the field {$.data.records.status} contains the value {invited}

  @connections @negative
  Scenario Outline: OCM - Try to get connection by providing invalid connectionID - <connId> - Negative
    Given an administrator fetches connection with connectionId {<connId>}
    Then the field {statusCode} contains the value {404}
    Then the field {message} contains the value {No Data found}
    Examples:
      | connId    |
      | dasdasdas |

