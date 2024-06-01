Feature: Web form page

  Background:
    * driver url_form_page
    * def locator = read('../../locators.js')

  @allure.label.epic:Web_interface_(Karate)
  #@allure.label.parentSuite:Web_interface_(Karate)
  @allure.label.suite:Web_interface_(Karate)
  Scenario:
    * screenshot()
    * input(locator('form_page', 'input'), 'login')
    * input(locator('form_page', 'password'), 'password')
    * input(locator('form_page', 'textarea'), 'My textarea')
    * select(locator('form_page', 'number'), 2)
    # * if (browser = 'chrome') driver.inputFile(locator('form_page', 'file'), '../../file.txt')
    * input(locator('form_page', 'city'), 'Los Angeles')
    * input(locator('form_page', 'color'), '#00ff00')
    * input(locator('form_page', 'date'), '01/01/2024')
    * click('//body')
    # * input(locator('form_page', 'range'), '1')
    * screenshot()
    * submit().click(locator('form_page', 'button'))
    * screenshot()
    * match text('//h1') == "Form submitted"
