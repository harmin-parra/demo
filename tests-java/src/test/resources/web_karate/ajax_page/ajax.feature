Feature: Ajax page

  Background:
    * driver url_ajax_page

  @allure.label.epic:Web_interface_(Karate)
  @allure.label.suite:Web_interface_(Karate)
  Scenario:
    * screenshot()
    * click('#button')
    * screenshot()
    * waitFor('#title')
    # * retry(5, 2000).waitFor('#title')
    * screenshot()
    * match text('#title') == "AJAX"
