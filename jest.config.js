/* eslint-env node */

module.exports = {
  resolver: require.resolve("jest-pnp-resolver"),
  testEnvironment: "jsdom",
  globalSetup: "./testjs/setup-tests.js"
};
