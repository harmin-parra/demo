@ignore
Feature: Call subtest Web form page

  Background:
    * driver url_form_page

  Scenario:
    * screenshot()
    * call read('classpath:examples/fill_in_form.feature') { login: 'login', password: 'password', text: 'Hello, World!', number: 2, city: 'Los Angeles', color: '#00FF00', date: '01/01/2024', range: 1 }
    * screenshot()
    * submit().click('button')
    * screenshot()
    * match text('//h1') == "Form submitted"
