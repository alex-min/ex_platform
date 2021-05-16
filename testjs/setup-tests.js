/* eslint-env node */

import { JSDOM } from "jsdom";

module.exports = function() {
  const dom = new JSDOM();
  global.document = dom.window.document;
  global.window = dom.window;
};