@allure.label.parentSuite:REST_api
@allure.label.suite:Petstore
@allure.label.epic:REST_api
@allure.label.package:rest_api.cucumber.petstore
Feature: Petstore

  Scenario: Add a pet
    Given I have a pet store
    When I add a pet
    Then The pet is added


#  Scenario: Query pet
#    Given A pet exists in the store
#    When I query a pet
#    Then I get the pet information


  Scenario: Delete a pet
    Given A pet exists in the store
    When I delete a pet
    Then The pet is deleted


#  Scenario: Update existing pet
#    Given A pet exists in the store
#    When I update a pet
#    Then The pet is updated
