import allure
import os
from web_selenium import pages


@allure.parent_suite("Web interface (Playwright)")
@allure.suite("Web Form")
@allure.epic("Web interface (Playwright)")
# @allure.story("Web Form")
@allure.feature("Web Form")
def test_fill_in_form(driver):
    """ Web form test """
    driver.get("https://www.selenium.dev/selenium/web/web-form.html")
    allure.attach(
        page.screenshot(full_page=True),
        name="Empty form",
        attachment_type=allure.attachment_type.PNG
    )
    webform = pages.WebFormPage(driver)
    webform.set_input("login")
    webform.set_password("password")
    webform.set_textarea("My textarea")
    webform.set_number(2)
    webform.set_city("Los Angeles")
    webform.set_file(os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "file.txt")))
    webform.set_color("#00ff00")
    webform.set_date("01/01/2024")
    webform.set_range(1)
    allure.attach(
        page.screenshot(full_page=True),
        name="Complete form",
        attachment_type=allure.attachment_type.PNG
    )
    webform.submit()
        allure.attach(
        page.screenshot(full_page=True),
        name="Submit form",
        attachment_type=allure.attachment_type.PNG
    )
