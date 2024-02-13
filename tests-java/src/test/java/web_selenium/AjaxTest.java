package web_selenium;

import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;

import web_selenium.AjaxPage;

public class AjaxTest {

	private WebDriver driver;

	@BeforeEach
	public void setup() {
		String browserName = StringUtils.isEmpty(System.getProperty("browser")) ? "firefox" : System.getProperty("browser");
		switch (browserName) {
		case "firefox":
			FirefoxOptions opt1 = new FirefoxOptions();
			opt1.addArguments("--headless");
			this.driver = new FirefoxDriver(opt1);
			break;
		case "chrome":
			ChromeOptions opt2 = new ChromeOptions();
			opt2.addArguments("--headless");
			this.driver = new ChromeDriver(opt2);
			break;
		case "edge":
			EdgeOptions opt3 = new EdgeOptions();
			opt3.addArguments("--headless=new");
			this.driver = new EdgeDriver(opt3);
			break;
		default:
			throw new IllegalArgumentException("Unexpected value: " + browserName);
		}
		this.driver.manage().window().maximize();
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
