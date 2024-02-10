const path = require("path");

module.exports = {
  default: {
    format: [path.resolve(__dirname, "reporter.js")],
  },
};
