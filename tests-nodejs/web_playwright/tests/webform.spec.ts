const { test, expect, Page } = require('@playwright/test');
import { allure, LabelName } from "allure-playwright";
import WebformPage from '../pages/webform.page';


//test.describe('Web Form', () => {

  test.beforeEach(async ({ page }) => {
    await page.goto("https://www.selenium.dev/selenium/web/web-form.html");
  });


  test('Fill in form', async ({ page }) => {
    await allure.epic("Web interface");
    //await allure.feature("Web Form");
    await allure.story("Web Form");
    await allure.parentSuite("Web interface");
    await allure.suite("Web Form");
    await allure.label(LabelName.PACKAGE, "web_playwright.webform.spec.ts");

    await allure.attachment("Empty form", await page.screenshot(), { contentType: "image/png" });
    var webform = new WebformPage(page);
    await webform.set_input("login");
    await webform.set_password("password");
    await webform.set_textarea("textarea");
    await webform.set_number(2);
    await webform.set_city("Los Angeles");
    await webform.set_file("file.txt");
    await webform.set_color("#00ff00");
    await webform.set_date("01/01/2024");
    await webform.set_range(1);
    await allure.attachment("Complete form", await page.screenshot(), { contentType: "image/png" });
    await webform.submit();
    await allure.attachment("Submit form", await page.screenshot(), { contentType: "image/png" });
  });

//});
