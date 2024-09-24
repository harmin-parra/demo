import allure
import time
from playwright.sync_api import Page, expect
from web_playwright import pages


@allure.link("https://www.selenium.dev/selenium/web/web-form.html", name="Target webpage")
@allure.issue("JIRA-123")
@allure.testcase("TEST-456")
@allure.parent_suite("Web interface (Playwright)")
@allure.suite("Ajax")
@allure.epic("Web interface (Playwright)")
#@allure.story("Ajax")
@allure.feature("Ajax")
def test_ajax_verification_with_expect_response(page: Page):
    """ 
    Testing an AJAX page.
    
    Test using page.expect_response()
    """
    page.goto("http://qa-demo.gitlab.io/reports/web/ajax.html")
    # extras.save_screenshot_for_playwright(page, comment="Initial page")
    allure.attach(
        page.screenshot(full_page=True),
        name="Initial page",
        attachment_type=allure.attachment_type.PNG
    )
    ajax = pages.AjaxPage(page)

    with page.expect_response("**/ajax.txt") as response:
        ajax.click()
        # extras.save_screenshot_for_playwright(page, comment="Trigger event")
        allure.attach(
            page.screenshot(full_page=True),
            name="Trigger event",
            attachment_type=allure.attachment_type.PNG
        )

    ajax.verify_text()
    # extras.save_screenshot_for_playwright(page, comment="Verify event result")
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
# def test_ajax_verification_with_expect(page: Page):
#     """ Ajax test using sleep() and default timeout """
#     page.goto("http://qa-demo.gitlab.io/reports/web/ajax.html")
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
#     ajax.verify_text()
#     allure.attach(
#         page.screenshot(full_page=True),
#         name="Verify event result",
#         attachment_type=allure.attachment_type.PNG
#     )
