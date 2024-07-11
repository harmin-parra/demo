Feature: List users

  Background:
    * url 'https://reqres.in/api/'


  Scenario: List all users
    Given path 'users'
    When method get
    Then status 200


  Scenario: List single user
    Given path 'users', 2
    When method get
    Then status 200
    And match response.data.id == 2


  Scenario: List unknown user
    Given path 'users', 23
    When method get
    Then status 404
    And match response == {}
