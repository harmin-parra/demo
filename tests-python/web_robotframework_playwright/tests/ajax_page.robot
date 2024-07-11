*** Settings ***
Documentation     Testing an Ajax page.

Resource          ../keywords/ajax.robot
Library     AllureLibrary

*** Test Cases ***
test_ajax_response
    [TAGS]
    ...  allure.label.epic:Web interface (Robot Framework)
    #...  allure.label.parentSuite:Web interface (Robot Framework)
    #...  allure.label.suite:Ajax
    ...  allure.label.story:Ajax
    ...  allure.label.package:web_robotframework.ajax_test
    ...  allure.label.testMethod:test_ajax_response
    Open Browser To Ajax Page
    Take Screenshot   EMBED    fullPage=True
    Click Button
    Take Screenshot   EMBED    fullPage=True
    Wait Ajax Response
    Take Screenshot   EMBED    fullPage=True
    Verify Ajax Response
