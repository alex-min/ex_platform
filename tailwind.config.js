/* eslint-env node */

module.exports = {
  mode: "jit",
  purge:  [
    "lib/**/*.html.eex",
    "lib/**/*.html.leex",
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
