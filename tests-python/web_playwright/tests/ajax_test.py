import allure
import time
from playwright.sync_api import Page, expect
from web_playwright import pages


@allure.parent_suite("Web interface (Playwright)")
@allure.suite("Ajax")
@allure.epic("Web interface (Playwright)")
#@allure.story("Ajax")
@allure.feature("Ajax")
def test_ajax_response(page: Page):
    """ Ajax test using except_response() """
    page.goto("http://harmin-demo.gitlab.io/reports/web/ajax.html")
    allure.attach(
        page.screenshot(full_page=True),
        name="Initial page",
        attachment_type=allure.attachment_type.PNG
    )
    ajax = pages.AjaxPage(page)

    with page.expect_response("**/ajax.txt") as response:
        ajax.click()
        allure.attach(
            page.screenshot(full_page=True),
            name="Trigger event",
            attachment_type=allure.attachment_type.PNG
        )

    ajax.verify_text()
    allure.attach(
        page.screenshot(full_page=True),
        name="Verify event result",
        attachment_type=allure.attachment_type.PNG
    )


# @allure.parent_suite("Web interface (Playwright)")
# @allure.suite("Ajax")
# @allure.epic("Web interface (Playwright)")
# @allure.story("Ajax")
# @allure.feature("Ajax using expect")
# def test_ajax_using_sleep(page: Page):
#     """ Ajax test using except() """
#     page.goto("http://harmin-demo.gitlab.io/reports/web/ajax.html")
#     allure.attach(
#         page.screenshot(full_page=True),
#         name="Initial page",
#         attachment_type=allure.attachment_type.PNG
#     )
#     ajax = pages.AjaxPage(page)
#
#     ajax.click()
#     allure.attach(
#         page.screenshot(full_page=True),
#         name="Trigger event",
#         attachment_type=allure.attachment_type.PNG
#     )
#
#     time.sleep(3)
#     ajax.verify_text()
#     allure.attach(
#         page.screenshot(full_page=True),
#         name="Verify event result",
#         attachment_type=allure.attachment_type.PNG
#     )
