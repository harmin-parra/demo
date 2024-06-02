## Summary

Sample source code of automated test of web pages and a REST api.

The objective is to implement the same tests using different automation test tools and different programming languages.

## HTML reports

- https://harmin-parra.github.io/demo/report-java/index.html (for Allure Java tests)
- https://harmin-parra.github.io/demo/report-python/allure.html (for Allure Python tests)
- https://harmin-parra.github.io/demo/report-playwright.html (for Playwright/Node.js tests)
- https://harmin-parra.github.io/demo/report-cypress.html (for Cypress tests)


## Test Targets

The web pages under test:

- https://www.selenium.dev/selenium/web/web-form.html
- http://harmin-demo.gitlab.io/reports/web/ajax.html

The REST api under test:

- https://petstore.swagger.io/

## Programming languages

The same tests were developed using the following programming languages:
- Python
- Java
- Node.js

## Automation test tools

The same tests were developed using:
- For web pages tests:
  - [Selenium](https://www.selenium.dev/)
  - [Playwright](https://playwright.dev/)
  - [Cypress](https://www.cypress.io/)
- For API tests:
  - [Cucumber](https://cucumber.io/)

## Detail of tools and frameworks

| Category            | Python                        | Java                          | Node.js                      |
|---------------------|-------------------------------|-------------------------------|------------------------------|
| Web test tools      | - Playwright <br/> - Selenium | - Playwright <br/> - Selenium | - Playwright <br/> - Cypress |
| Cucumber            | Behave                        | Cucumber-JVM                  | Cucumber-js                  |
| Unit test framework | Pytest                        | JUnit5                        | Mocha                        |
| Package manager     | pip                           | Maven                         | npm                          |
