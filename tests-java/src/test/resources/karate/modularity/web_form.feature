Feature: Web form page

  Background:
    * driver url_form_page

  @allure.label.epic:Web_interface_(Karate)
  #@allure.label.parentSuite:Web_interface_(Karate)
  @allure.label.suite:Web_interface_(Karate)
  Scenario:
    * screenshot()
    * call read('classpath:karate/share/web_form.feature') { login: 'login', password: 'password', textarea: "Text Area", number: 2, city: 'Los Angeles', color: '#00FF00', date: '01/01/2024' }
    * screenshot()
    * match text('//h1') == "Form submitted"
