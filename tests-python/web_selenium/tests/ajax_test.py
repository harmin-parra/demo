from web_selenium.conftest import driver
from web_selenium import pages


def test_ajax_response(driver):
    driver.get("http://harmin-demo.gitlab.io/reports/web/ajax.html")
    ajax = pages.AjaxPage(driver)
    ajax.click()
    ajax.verify()
