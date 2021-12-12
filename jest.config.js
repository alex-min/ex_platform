/* eslint-env node */

module.exports = {
  resolver: require.resolve("jest-pnp-resolver"),
  testEnvironment: "jsdom",
  globalSetup: "./testjs/setup-tests.js",
  moduleNameMapper: {
    "\\.(css|less|scss|sass)$": "identity-obj-proxy"
  },
  roots: [
    "testjs"
  ],
  testMatch: [
    "./**/*.test.js"
  ],
  moduleDirectories: [
    "node_modules"
  ],
  transform: {
    "^.+\\.js?$": "babel-jest"
  }
};
