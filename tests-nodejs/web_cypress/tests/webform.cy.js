import WebFormPage from "../pages/webform";


describe('Web Form', () => {

  it('fill in form', () => {
    cy.visit('https://www.selenium.dev/selenium/web/web-form.html')
    const page = new WebFormPage();
    cy.screenshot();
    page.set_input("input");
    page.set_password("password");
    page.set_textarea("textarea");
    page.set_number(2);
    page.set_city("Los Angeles");
    page.set_file("file.txt");
    page.set_color("#00ff00");
    page.set_date("01/01/2024");
    page.set_range(1);
    cy.screenshot();
    page.submit();
    cy.screenshot();
  });

});
