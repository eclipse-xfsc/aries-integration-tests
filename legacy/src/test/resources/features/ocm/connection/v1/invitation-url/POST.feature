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

#http://localhost/ocm/connection/v1/invitation-url
#Author: Rosen Georgiev rosen.georgiev@vereign.com

@rest @all @ocm
Feature: API - OCM - connection - v1 - invitation-url POST
  It is used to create the connection invitation URL to establish the peer to peer connection,
  between two aeries agents or the participant user and the principal user.


  Background:
    Given we are testing the OCM Api

  @connection
  Scenario Outline: OCM - Creating a new process connection with alias <alias>- Positive
#Create a new member process connection
    Given an administrator generates a QR code by creating a connection with alias {<alias>} via OCM api
    Then the field {statusCode} contains the value {200}
    And the status code should be {201}
    And the response is valid according to the {Connection_POST_invitationURL.json} REST schema
    Then the field {message} contains the value {Connection created successfully}
    And the field {$..state} contains the value {invited}
    And the field {$..role} contains the value {inviter}
    And the field {$..alias} contains the value {<alias>}
    Examples:
      | alias      |
      | member     |
      | subscriber |

  @connection @negative
  Scenario Outline: OCM - Trying to create a new member process connection with invalid alias <alias> - Negative
#Create a new member process connection
    Given an administrator generates a QR code by creating a connection with alias {<alias>} via OCM api
    Then the field {statusCode} contains the value {400}
    And the status code should be {400}
    Then the field {message} contains the value {Alias must be provided}
    Examples:
      | alias   |
      | dsadasd |
      |         |

  @connection @negative
  Scenario: OCM - Trying to create a new member process connection without alies - Negative
#Create a new member process connection
    Given an administrator generates a QR code by creating a connection via OCM api
    Then the field {statusCode} contains the value {400}
    And the status code should be {400}
    Then the field {message} contains the value {Alias must be provided}