import allure
import os
from playwright.sync_api import Page
from web_playwright import pages


@allure.parent_suite("Web interface")
@allure.suite("Web Form")
@allure.epic("Web interface")
# @allure.story("Web Form")
@allure.feature("Web Form")
def test_fill_in_form(page: Page):
    """ Web form test """
    page.goto("https://www.selenium.dev/selenium/web/web-form.html")
    allure.attach(
        page.screenshot(full_page=True),
        name="Empty form",
        attachment_type=allure.attachment_type.PNG
    )
    webform = pages.WebFormPage(page)
    webform.set_input("login")
    webform.set_password("password")
    webform.set_textarea("My textarea")
    webform.set_number(2)
    webform.set_city("Los Angeles")
    webform.set_file(os.path.join("file.txt"))
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
