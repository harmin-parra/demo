package web_playwright;

import io.qameta.allure.Allure;
import web_playwright.WebFormPage;

import com.microsoft.playwright.Browser;
import com.microsoft.playwright.BrowserContext;
import com.microsoft.playwright.BrowserType;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.Playwright;

import java.io.ByteArrayInputStream;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class WebFormTest {

    static private Playwright playwright;
    static private Browser browser;
    private BrowserContext context;
    private Page page;

    @BeforeAll
    static void launchBrowser() {
        playwright = Playwright.create();
        browser = playwright.chromium().launch(new BrowserType.LaunchOptions().setHeadless(true));
    }

    @BeforeEach
    void createContextAndPage() {
        this.context = browser.newContext();
        this.page = context.newPage();
    }

    @Test
    public void fill_in_form() {
    	Allure.epic("Web interface");
    	//Allure.story("Web Form");
    	Allure.suite("Web interface");
    	Allure.feature("Web Form");
        this.page.navigate("https://www.selenium.dev/selenium/web/web-form.html");
        WebFormPage webform = new WebFormPage(page);
        byte[] buffer = page.screenshot(new Page.ScreenshotOptions().setFullPage(true));
        Allure.addAttachment("Empty form", new ByteArrayInputStream(buffer));
        webform.set_input("login");
        webform.set_password("password");
        webform.set_textarea("textarea");
        webform.set_number(2);
        webform.set_city("Los Angeles");
        webform.set_file("src/test/resources/file.txt");
        webform.set_color("#00ff00");
        webform.set_date("01/01/2024");
        webform.set_range(1);
        buffer = page.screenshot(new Page.ScreenshotOptions().setFullPage(true));
        Allure.addAttachment("Complete form", new ByteArrayInputStream(buffer));
        webform.submit();
        buffer = page.screenshot(new Page.ScreenshotOptions().setFullPage(true));
        Allure.addAttachment("Submit form", new ByteArrayInputStream(buffer));
    }

    @AfterAll
    static void closeBrowser() {
        playwright.close();
    }

    @AfterEach
    void closeContext() {
        this.context.close();
    }

}
