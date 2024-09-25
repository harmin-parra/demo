import os
from web_pytest.conftest import driver
from web_pytest import pages


def test_fill_in_form(driver, extras):
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
    extras.screenshot_selenium(driver, "Empty form")
    webform = pages.WebFormPage(driver)
    webform.set_input("login")
    webform.set_password("password")
    webform.set_textarea("My textarea")
    webform.set_number(2)
    webform.set_city("Los Angeles")
    webform.set_file("/tmp/test/file.xml")
    webform.set_color("#00ff00")
    webform.set_date("01/01/2024")
    webform.set_range(1)
    extras.screenshot_selenium(driver, "Complete form")
    print(extras.format_xml_file("/tmp/test/file.xml"))
    webform.submit()
    extras.screenshot_selenium(driver, "Submit form")
