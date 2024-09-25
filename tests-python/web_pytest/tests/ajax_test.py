from web_pytest.conftest import driver
from web_pytest import pages


def test_ajax_verification(driver, extras):
    """
    Testing an AJAX page.

    Test using WebDriverWait().until()
    """
    driver.get("http://qa-demo.gitlab.io/reports/web/ajax.html")
    extras.screenshot_selenium(driver, "Initial page")
    ajax = pages.AjaxPage(driver)
    ajax.click()
    extras.screenshot_selenium(driver, "Trigger event")
    ajax.verify()
    extras.screenshot_selenium(driver, "Verify event result")
