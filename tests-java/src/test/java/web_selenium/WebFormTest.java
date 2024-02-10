package web_selenium;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import web_selenium.WebFormPage;

public class WebFormTest {

    private WebDriver driver;

    @BeforeEach
    public void setup() {
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless=new");
        this.driver = new ChromeDriver(options);
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
        try { this.driver.quit(); } catch(Exception e) { }
    }
}
