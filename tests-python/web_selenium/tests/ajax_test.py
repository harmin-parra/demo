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
        driver.get_screenshot_as_png(),
        name="Initial page",
        attachment_type=allure.attachment_type.PNG
    )
    ajax = pages.AjaxPage(driver)
    ajax.click()
    allure.attach(
        driver.get_screenshot_as_png(),
        name="Trigger event",
        attachment_type=allure.attachment_type.PNG
    )
    ajax.verify()
    allure.attach(
        driver.get_screenshot_as_png(),
        name="Verify event result",
        attachment_type=allure.attachment_type.PNG
    )
