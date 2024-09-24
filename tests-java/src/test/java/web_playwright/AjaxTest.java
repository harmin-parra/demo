package web_playwright;

import java.io.ByteArrayInputStream;
import io.qameta.allure.Allure;
import io.qameta.allure.*;

import org.apache.commons.lang3.StringUtils;
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
import com.microsoft.playwright.BrowserType.LaunchOptions;

public class AjaxTest {

    static private Playwright playwright;
    static private Browser browser;
    private BrowserContext context;
    private Page page;

    @BeforeAll
    public static void launchBrowser() {
        playwright = Playwright.create();
        LaunchOptions options = new BrowserType.LaunchOptions().setHeadless(true);
        String browserName = StringUtils.isEmpty(System.getProperty("browser")) ? "firefox" : System.getProperty("browser");
        if (browserName.equals("chromium"))
            browser = playwright.chromium().launch(options);
        else if (browserName.equals("firefox"))
            browser = playwright.firefox().launch(options);
        else if (browserName.equals("webkit"))
            browser = playwright.webkit().launch(options);
        else if (browserName.equals("chrome") || browserName.equals("msedge"))
            browser = playwright.chromium().launch(options.setChannel(browserName));
    }

    @BeforeEach
    public void createContextAndPage() {
        this.context = browser.newContext();
        this.page = context.newPage();
    }

    /**
     * Testing an AJAX page.
     *
     * Test using <code>page.waitForResponse</code>.
     */
    @Test
    @Description(useJavaDoc = true)
    @Link(name = "Target AJAX page", url = "https://qa-demo.gitlab.io/reports/web/ajax.html")
    @Issue("JIRA-123")
    @TmsLink("TEST-456")
    @Epic("Web interface (Playwright)")
    @Story("Ajax page")
    public void ajax_verification_with_intercept() {
        Allure.getLifecycle().updateTestCase(tr -> tr.getLabels().removeIf(label -> "suite".equals(label.getName())));
    	Allure.suite("Web interface (Playwright)");
        this.page.navigate("http://qa-demo.gitlab.io/reports/web/ajax.html");
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

    /**
     * Testing an AJAX page.
     *
     * Test using <code>assertThat().isAttached()</code>.
     */
    @Test
    @Description(useJavaDoc = true)
    @Link(name = "Target AJAX page", url = "https://qa-demo.gitlab.io/reports/web/ajax.html")
    @Issue("JIRA-123")
    @TmsLink("TEST-456")
    @Epic("Web interface (Playwright)")
    @Story("Ajax page")
    public void ajax_verification_with_assert() {
        Allure.getLifecycle().updateTestCase(tr -> tr.getLabels().removeIf(label -> "suite".equals(label.getName())));
    	Allure.suite("Web interface (Playwright)");
        this.page.navigate("http://qa-demo.gitlab.io/reports/web/ajax.html");
        byte[] buffer = page.screenshot(new Page.ScreenshotOptions().setFullPage(true));
        Allure.addAttachment("Initial page", new ByteArrayInputStream(buffer));
        AjaxPage ajax = new AjaxPage(this.page);
        ajax.click();
        buffer = page.screenshot(new Page.ScreenshotOptions().setFullPage(true));
        Allure.addAttachment("Trigger event", new ByteArrayInputStream(buffer));
        ajax.wait_ajax();
        ajax.verify();
        buffer = page.screenshot(new Page.ScreenshotOptions().setFullPage(true));
        Allure.addAttachment("Verify event result", new ByteArrayInputStream(buffer));
    }

    @AfterAll
    public static void closeBrowser() {
        playwright.close();
    }

    @AfterEach
    public void closeContext() {
        this.context.close();
    }

}
