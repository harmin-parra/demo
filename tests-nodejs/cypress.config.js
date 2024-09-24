const { defineConfig } = require("cypress");
//const { allureCypress } = require("allure-cypress/reporter");

module.exports = defineConfig({
  reporter: 'cypress-mochawesome-reporter',
  video: false,
  reporterOptions: {
    charts: true,
    reportPageTitle: 'Cypress Report',
    embeddedScreenshots: true,
    inlineAssets: true,
    reportDir: "../reporting/report-cypress",
  },
  e2e: {
    experimentalStudio: true,
    supportFile: 'web_cypress/support/e2e.{js,jsx,ts,tsx}',
    specPattern: 'web_cypress/tests/**/*.cy.{js,jsx,ts,tsx}',
    fixturesFolder: 'web_cypress/fixtures',
    setupNodeEvents(on, config) {
      //require('cypress-mochawesome-reporter/plugin')(on);
      /*
      allureCypress(on, {
        resultsDir: "../reporting/allure-results/nodejs",
        links: [
          { type: "issue", urlTemplate: "https://example.com/JIRA-%s" },
          { type: "tms", urlTemplate: "https://example.com/TEST-%s" },
        ],
      });
      */
      require('cypress-mochawesome-reporter/plugin')(on);
    },
  },
});
