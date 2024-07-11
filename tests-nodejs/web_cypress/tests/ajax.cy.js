import AjaxPage from "../pages/ajax.js";


describe("Ajax page", () => {

  it("Ajax verification with intercept", () =>{
    cy.visit("https://harmin-demo.gitlab.io/reports/web/ajax.html")
    const page = new AjaxPage();
    cy.screenshot();
    page.click();
    cy.screenshot();
    cy.intercept("GET", "**/ajax.txt").as("ajaxResponse");
    cy.wait("@ajaxResponse", {timeout: 10000}).its("response.statusCode").should("equal", 200);
    cy.screenshot();
    page.verify();
  });


  it("Ajax verification with get+should", () =>{
    cy.visit("https://harmin-demo.gitlab.io/reports/web/ajax.html")
    const page = new AjaxPage();
    cy.screenshot();
    page.click();
    cy.screenshot();
    cy.get("#title", { timeout: 10000 }).should("exist");
    cy.screenshot();
    page.verify();
  });

});
