import allure
import os
from web_selenium import pages


@allure.link("https://www.selenium.dev/selenium/web/web-form.html", name="Target webform")
@allure.issue("JIRA-123")
@allure.testcase("TEST-456")
@allure.parent_suite("Web interface (Selenium)")
@allure.suite("Web Form")
@allure.epic("Web interface (Selenium)")
# @allure.story("Web Form")
@allure.feature("Web Form")
def test_fill_in_form(driver):
    """
    Testing the following field types of a webform :

    - Input text
    - Text area
    - Select
    - Checkbox
    - Radio button
    - File upload
    - Color picker
    - Date picker
    - Input range
    - Button
    """
    driver.get("https://www.selenium.dev/selenium/web/web-form.html")
    allure.attach(
        driver.get_screenshot_as_png(),
        name="Empty form",
        attachment_type=allure.attachment_type.PNG
    )
    webform = pages.WebFormPage(driver)
    webform.set_input("login")
    webform.set_password("password")
    webform.set_textarea("My textarea")
    webform.set_number(2)
    webform.set_city("Los Angeles")
    #webform.set_file(os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "file.xml")))
    webform.set_file("/tmp/test/file.xml")
    webform.set_color("#00ff00")
    webform.set_date("01/01/2024")
    webform.set_range(1)
    allure.attach(
        driver.get_screenshot_as_png(),
        name="Complete form",
        attachment_type=allure.attachment_type.PNG
    )
    allure.attach(
        open("/tmp/test/file.xml").read(),
        name="File to upload",
        attachment_type=allure.attachment_type.XML
    )
    webform.submit()
    allure.attach(
        driver.get_screenshot_as_png(),
        name="Submit form",
        attachment_type=allure.attachment_type.PNG
    )
