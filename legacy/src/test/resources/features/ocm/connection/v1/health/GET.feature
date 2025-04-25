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

#http://localhost/ocm/connection/v1/health
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm @connection
Feature: API - OCM - connection - v1 - health GET
  Connection manager health check

  Background:
    Given we are testing the OCM Api

  @health
  Scenario: OCM - Connection - Health check - Positive
    Given we call the health check for connection manager via OCM api
    Then the field {statusCode} contains the value {200}
    And the status code should be {200}
    And the field {message} is present and not empty
    And I clear the request body