class AjaxPage {

  elements = {
    button : () => cy.get("#button"),
    title : () => cy.get("#title")
  }


  click() {
    this.elements.button().click();
  }

  verify() {
    this.elements.title().should('exist');
    this.elements.title().should("have.text", "AJAX");
  }

}

module.exports = AjaxPage;
