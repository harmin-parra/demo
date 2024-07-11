@ignore
Feature: form utility

  Background:
    * def locator = read('classpath:karate/share/locators.js')

  Scenario:
    * input(locator('form_page', 'input'), login)
    * input(locator('form_page', 'password'), password)
    * input(locator('form_page', 'textarea'), textarea)
    * select(locator('form_page', 'number'), number)
    # * if (browser = 'chrome') driver.inputFile(locator('form_page', 'file'), '../../file.txt')
    * input(locator('form_page', 'city'), city)
    * input(locator('form_page', 'color'), color)
    * input(locator('form_page', 'date'), date)
    * click('//body')
    # * input(locator('form_page', 'range'), '1')
    * screenshot()
    * submit().click(locator('form_page', 'button'))
