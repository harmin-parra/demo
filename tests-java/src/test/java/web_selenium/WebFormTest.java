package web_selenium;

import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;

import web_selenium.WebFormPage;

public class WebFormTest {

    private WebDriver driver;

    @BeforeEach
    public void setup() {
        String browserName = StringUtils.isEmpty(System.getProperty("browser")) ? "chrome" : System.getProperty("browser");
        String url = StringUtils.isEmpty(System.getProperty("hub")) ? "172.17.0.1" : System.getProperty("hub");
        URL hub = null;
        try {
            hub = new URL("http://" + url + ":4444/wd/hub");
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        switch (browserName) {
        case "firefox":
            FirefoxOptions opt1 = new FirefoxOptions();
            opt1.addArguments("--headless");
            // this.driver = new FirefoxDriver(opt1);
            this.driver = new RemoteWebDriver(hub, opt1);
            break;
        case "chrome":
            ChromeOptions opt2 = new ChromeOptions();
            opt2.addArguments("--headless");
            // this.driver = new ChromeDriver(opt2);
            this.driver = new RemoteWebDriver(hub, opt2);
            break;
        case "edge":
            EdgeOptions opt3 = new EdgeOptions();
            opt3.addArguments("--headless=new");
            // this.driver = new EdgeDriver(opt3);
            this.driver = new RemoteWebDriver(hub, opt3);
            break;
        case "chromium":
            ChromeOptions opt4 = new ChromeOptions();
            opt4.addArguments("--headless=new");
            // opt4.setBinary("/usr/bin/chromium");
            // this.driver = new ChromeDriver(opt4);
            this.driver = new RemoteWebDriver(hub, opt4);
            break;
        default:
            throw new IllegalArgumentException("Unexpected value: " + browserName);
        }
        this.driver.manage().window().maximize();
    }

    @Test
    public void testFillInForm() {
        this.driver.get("https://www.selenium.dev/selenium/web/web-form.html");
        WebFormPage page = new WebFormPage(this.driver);
        page.set_input("login");
        page.set_password("password");
        page.set_textarea("textarea");
        page.set_number(2);
        page.set_city("Los Angeles");
        page.set_file("src/test/resources/file.txt");
        page.set_color("#00ff00");
        page.set_date("01/01/2024");
        page.set_range(1);
        page.submit();
    }

    @AfterEach
    public void teardown() {
        try {
            this.driver.quit();
        } catch (Exception e) { }
    }
}
