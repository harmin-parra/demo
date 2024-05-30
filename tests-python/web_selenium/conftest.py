import pytest
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.service import Service
from selenium import webdriver
from selenium.webdriver.firefox.webdriver import WebDriver


def pytest_addoption(parser):
    parser.addoption("--driver", action="store", default="chromium")


@pytest.fixture(scope='session')
def browser(request):
    return request.config.getoption("--driver")


@pytest.fixture(scope="function")
def driver(browser):
    options = Options()
    options.add_argument("--headless")
    driver = webdriver.Firefox(options=options)
    yield driver
    driver.quit()
