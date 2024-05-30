import allure
from web_selenium.conftest import driver
from web_selenium import pages


@allure.parent_suite("Web interface (Playwright)")
@allure.suite("Ajax")
@allure.epic("Web interface (Playwright)")
#@allure.story("Ajax")
@allure.feature("Ajax")
def test_ajax_response(driver):
    driver.get("http://harmin-demo.gitlab.io/reports/web/ajax.html")
    allure.attach(
        page.get_screenshot_as_base64(),
        name="Initial page",
        attachment_type=allure.attachment_type.PNG
    )
    ajax = pages.AjaxPage(driver)
    ajax.click()
    allure.attach(
        page.get_screenshot_as_base64(),
        name="Trigger event",
        attachment_type=allure.attachment_type.PNG
    )
    ajax.verify()
    allure.attach(
        page.get_screenshot_as_base64(),
        name="Verify event result",
        attachment_type=allure.attachment_type.PNG
    )
