const { test, expect, Page } = require('@playwright/test');
import { allure, LabelName } from "allure-playwright";
import AjaxPage from '../pages/ajax.page';
const assert = require('assert');


//test.describe('Ajax', () => {

  test.beforeEach(async ({ page }) => {
    await page.goto("https://harmin-demo.gitlab.io/reports/web/ajax.html");
  });


  test('Ajax verification', async ({ page }) => {
    await allure.description("Testing a webpage using AJAX");
    await allure.link("https://harmin-demo.gitlab.io/reports/web/ajax.html", "Target AJAX page");
    await allure.issue("JIRA-123", "https://example.com/JIRA-123");
    await allure.tms("TEST-456", "https://example.com/TEST-456");
    await allure.epic("Web interface");
    //await allure.feature("Ajax");
    await allure.story("Ajax");
    await allure.parentSuite("Web interface");
    await allure.suite("Ajax");
    await allure.label(LabelName.PACKAGE, "web_playwright.ajax.spec.ts");

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


  /*
  test('Ajax verification', async ({ page }) => {
    await allure.epic("Web interface");
    await allure.feature("Ajax");
    await allure.story("Ajax");
    await allure.parentSuite("Web interface");
    await allure.suite("Ajax");

    await allure.attachment("Initial page", await page.screenshot(), { contentType: "image/png" });
    var ajax = new AjaxPage(page);
    await ajax.click();
    await allure.attachment("Trigger event", await page.screenshot(), { contentType: "image/png" });
    await expect(ajax.title).toBeVisible({ timeout: 10000 });
    await ajax.verify();
    await allure.attachment("Verify event result", await page.screenshot(), { contentType: "image/png" });
  });
  */

//});
