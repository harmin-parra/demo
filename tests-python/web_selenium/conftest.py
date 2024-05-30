import pytest

from selenium import webdriver
from selenium.webdriver.firefox.webdriver import WebDriver
from selenium.webdriver.firefox.options import Options as Options_Firefox
from selenium.webdriver.chrome.options import Options as Options_Chrome
from selenium.webdriver.chromium.options import ChromiumOptions as Options_Chromium
from selenium.webdriver.edge.options import Options as Options_Edge

def pytest_addoption(parser):
    parser.addoption("--driver", action="store", default="chromium")
    parser.addoption("--hub", action="store", default="172.17.0.1")


@pytest.fixture(scope='session')
def browser(request):
    return request.config.getoption("--driver")


@pytest.fixture(scope='session')
def hub(request):
    return request.config.getoption("--hub")


@pytest.fixture(scope="function")
def driver(browser, hub):
    server = f"http://{hub}:4444/wd/hub"
    options = None
    if browser == "chrome":
        options = Options_Chrome()
    elif browser == "chromium":
        options = Options_Chromium()
    elif browser == "firefox":
        options = Options_Firefox()
        #options.add_argument("--headless")
        #driver = webdriver.Firefox(options=options)
    elif browser == "edge":
        options = Options_Edge()
    options.add_argument("--headless")
    driver = webdriver.Remote(command_executor=server, options=options)
    yield driver
    driver.quit()
