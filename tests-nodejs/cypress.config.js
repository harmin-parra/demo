const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    experimentalStudio: true,
    supportFile: 'web_cypress/support/e2e.{js,jsx,ts,tsx}',
    specPattern: 'web_cypress/tests/**/*.cy.{js,jsx,ts,tsx}',
    fixturesFolder: 'web_cypress/fixtures',
    setupNodeEvents(on, config) { },
  },
});
