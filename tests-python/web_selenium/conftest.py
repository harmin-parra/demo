import pytest
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.service import Service
from selenium import webdriver
from selenium.webdriver.firefox.webdriver import WebDriver


def pytest_addoption(parser):
    parser.addoption("--driver", action="store", default="chromium")


@pytest.fixture(scope='session')
def _browser(request):
    return request.config.getoption("--driver")


@pytest.fixture(scope="function")
def driver(_browser):
    server = "http://172.17.0.1:4444/wd/hub"
    options = Options()
    options.add_argument("--headless")
    #driver = webdriver.Firefox(options=options)
    driver = webdriver.Remote(command_executor=server, options=options)
    yield driver
    driver.quit()
