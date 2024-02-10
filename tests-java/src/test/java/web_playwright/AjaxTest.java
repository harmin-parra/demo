package web_playwright;

import io.qameta.allure.Allure;

import java.io.ByteArrayInputStream;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.microsoft.playwright.Browser;
import com.microsoft.playwright.BrowserContext;
import com.microsoft.playwright.BrowserType;

import com.microsoft.playwright.Page;
import com.microsoft.playwright.Playwright;
import com.microsoft.playwright.Response;


public class AjaxTest {

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
    public void ajax_response() {
    	Allure.epic("Web interface");
    	//Allure.story("Ajax page");
    	Allure.suite("Web interface");
    	Allure.feature("Ajax page");
        this.page.navigate("http://harmin-demo.gitlab.io/reports/web/ajax.html");
        byte[] buffer = page.screenshot(new Page.ScreenshotOptions().setFullPage(true));
        Allure.addAttachment("Initial page", new ByteArrayInputStream(buffer));
        AjaxPage ajax = new AjaxPage(this.page);
        Response response = page.waitForResponse("**/ajax.txt", () -> {
            ajax.click();;
            final byte[]buffer2 = page.screenshot(new Page.ScreenshotOptions().setFullPage(true));
            Allure.addAttachment("Trigger event", new ByteArrayInputStream(buffer2));
        });
        ajax.verify();
        buffer = page.screenshot(new Page.ScreenshotOptions().setFullPage(true));
        Allure.addAttachment("Verify event result", new ByteArrayInputStream(buffer));
    }

    /*
    @Test
    public void ajax_using_sleep() {
        this.page.navigate("http://harmin-demo.gitlab.io/reports/web/ajax.html");
        AjaxPage ajax = new AjaxPage(this.page);
        ajax.click();
        try { Thread.sleep(3000); } catch (Exception e) { }
        ajax.verify();
    }

    @Test
    public void ajax_using_assert() {
        this.page.navigate("http://harmin-demo.gitlab.io/reports/web/ajax.html");
        AjaxPage ajax = new AjaxPage(this.page);
        ajax.click();
        ajax.wait_ajax();
        ajax.verify();
    }
    */
    
    @AfterAll
    static void closeBrowser() {
        playwright.close();
    }

    @AfterEach
    void closeContext() {
        this.context.close();
    }

}
