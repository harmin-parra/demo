Feature: Petstore

  Scenario: Add a pet
    Given I have a pet store
    When I add a pet
    Then The pet is added


#  Scenario: Query existing pet
#    Given A pet exists in the store
#    When I query an existing pet
#    Then I get the pet information


  Scenario: Delete a pet
    Given A pet exists in the store
    When I delete a pet
    Then The pet is deleted
