package web_selenium;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import web_selenium.AjaxPage;

public class AjaxTest {

    private WebDriver driver;

    @BeforeEach
    public void setup() {
        ChromeOptions options = new ChromeOptions();
        options.addArguments();  //"--headless=new");
        this.driver = new ChromeDriver(options);
    }

    @Test
    public void ajax_response() {
        this.driver.get("http://harmin-demo.gitlab.io/reports/web/ajax.html");
        AjaxPage page = new AjaxPage(this.driver);
        page.click();
        page.wait_ajax();
        page.verify();
    }

    @AfterEach
    public void teardown() {
        try { this.driver.quit(); } catch(Exception e) { }
    }
}
