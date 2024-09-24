const { test, expect, Page } = require('@playwright/test');
import * as allure from "allure-js-commons";
import AjaxPage from '../pages/ajax.page';
const assert = require('assert');


//test.describe('Ajax tests', () => {

  test.beforeEach(async ({ page }) => {
    await page.goto("http://qa-demo.gitlab.io/reports/web/ajax.html");
  });


  test('Ajax verification with intercept', async ({ page }) => {
    await allure.description("Testing an AJAX page\n\nTest using ``page.waitForResponse()``");
    await allure.link("http://qa-demo.gitlab.io/reports/web/ajax.html", "Target AJAX page");
    await allure.issue("JIRA-123", "https://example.com/JIRA-123");
    await allure.tms("TEST-456", "https://example.com/TEST-456");
    await allure.epic("Web interface (Playwright)");
    //await allure.feature("Ajax");
    await allure.story("Ajax");
    await allure.parentSuite("Web interface (Playwright)");
    await allure.suite("Ajax");
    await allure.label(allure.LabelName.PACKAGE, "web_playwright.ajax.spec.ts");

    await allure.attachment("Initial page", await page.screenshot(), { contentType: "image/png" });
    var ajax = new AjaxPage(page);
    const responsePromise = ajax.page.waitForResponse('**/ajax.txt');
    await ajax.click();
    const response = await responsePromise;
    assert.equal(response.status(), 200);
    await allure.attachment("Trigger event", await page.screenshot(), { contentType: "image/png" });
    await ajax.verify();
    await allure.attachment("Verify event result", await page.screenshot(), { contentType: "image/png" });
  });


  test('Ajax verification with expect', async ({ page }) => {
    await allure.description("Testing an AJAX page\n\nTest using ``expect()``");
    await allure.link("http://qa-demo.gitlab.io/reports/web/ajax.html", "Target AJAX page");
    await allure.issue("JIRA-123", "https://example.com/JIRA-123");
    await allure.tms("TEST-456", "https://example.com/TEST-456");
    await allure.epic("Web interface (Playwright)");
    //await allure.feature("Ajax");
    await allure.story("Ajax");
    await allure.parentSuite("Web interface (Playwright)");
    await allure.suite("Ajax");
    await allure.label(allure.LabelName.PACKAGE, "web_playwright.ajax.spec.ts");

    await allure.attachment("Initial page", await page.screenshot(), { contentType: "image/png" });
    var ajax = new AjaxPage(page);
    await ajax.click();
    await allure.attachment("Trigger event", await page.screenshot(), { contentType: "image/png" });
    await expect(ajax.title).toBeVisible({ timeout: 15000 });
    await ajax.verify();
    await allure.attachment("Verify event result", await page.screenshot(), { contentType: "image/png" });
  });


//});
