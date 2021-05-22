/* eslint-env jest */

import glob from "glob";
import fs from "fs";
import "../../assets/js/app";

describe("Validate unused hook", () => {
  test("all hooks are defined", (cb) => {
    glob("lib/**/*.html.leex", {}, function (err, files) {
      if (err) {
        return cb(err);
      }
      const requiredHooks = {};

      function matchHook(file, content, regex) {
        let match = content.match(regex);
        if (match) {
          requiredHooks[match[1]] ||= [];
          if (requiredHooks[match[1]].indexOf(file) === -1) {
            requiredHooks[match[1]].push(file);
          }
        } 
      }
            
      files.forEach(file => {
        const content = fs.readFileSync(file).toString();
        matchHook(file, content, /phx_hook: *"([a-zA-Z_-]+)"/);
        matchHook(file, content, /phx-hook="([a-zA-Z_-]+)"/);
        matchHook(file, content, /phx-hook='([a-zA-Z_-]+)'/);
      });
      const installedHooks = Object.keys(window.liveSocket.hooks);
      const hooksMissings = [];

      for (let hookName in requiredHooks) {
        if (installedHooks.indexOf(hookName) === -1) {
          hooksMissings.push(hookName);
        }
      }

      let error = "These hooks are missing from the Javascript LiveSocket:\n";
      hooksMissings.forEach(hookName => {
        error += ` - The hook '${hookName}' is required in these files:\n`;
        requiredHooks[hookName].forEach(file => {
          error += `         ${file}\n`;
        });
      });
      error += "\n\nPlease add all these hooks in the Javascript part.";

      if (hooksMissings.length) {
        return cb(new Error(error));
      }
      return cb();
    });
  });
});
