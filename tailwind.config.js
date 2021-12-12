/* eslint-env node */

module.exports = {
  mode: "jit",
  purge:  [
    "lib/**/*.html.{heex,eex,leex}",
    "lib/**/views/**/*.ex",
    "lib/**/live/**/*.ex",
    "assets/js/**/*.js"
  ],
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
};
