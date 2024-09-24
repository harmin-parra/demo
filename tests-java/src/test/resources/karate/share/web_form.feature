@ignore
Feature: form

  Background:
    * def locator = read('classpath:karate/share/locators.js')

  Scenario:
    * input(locator('form_page', 'input'), login)
    * input(locator('form_page', 'password'), password)
    * input(locator('form_page', 'textarea'), textarea)
    * select(locator('form_page', 'number'), number)
    * input(locator('form_page', 'city'), city)
    * screenshot()
    * submit().click(locator('form_page', 'button'))
