Feature: Ajax page

  Background:
    * driver url_ajax_page
    * def locator = read('../../locators.js')

  @allure.label.epic:Web_interface_(Karate)
  @allure.label.suite:Web_interface_(Karate)
  Scenario:
    * screenshot()
    * click(locator('ajax_page', 'button'))
    * screenshot()
    * waitFor(locator('ajax_page', 'title'))
    * screenshot()
    * match text(locator('ajax_page', 'title')) == "AJAX"
