const { defineConfig } = require("cypress");

module.exports = defineConfig({
  reporter: 'cypress-mochawesome-reporter',
  video: false,
  reporterOptions: {
    charts: true,
    reportPageTitle: 'Cypress Inline Reporter',
    embeddedScreenshots: true, 
    inlineAssets: true,
    reportDir: "cypress/report",
  },
  e2e: {
    experimentalStudio: true,
    supportFile: 'web_cypress/support/e2e.{js,jsx,ts,tsx}',
    specPattern: 'web_cypress/tests/**/*.cy.{js,jsx,ts,tsx}',
    fixturesFolder: 'web_cypress/fixtures',
    setupNodeEvents(on, config) {
      require('cypress-mochawesome-reporter/plugin')(on);
    },
});
