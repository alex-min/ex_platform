/* eslint-env node */

const path = require("path");

module.exports = {
    mode: "jit",
    purge:  [
        path.resolve(__dirname, "./lib/**/*.html.eex"),
        path.resolve(__dirname, "./lib/**/*.html.leex"),
        path.resolve(__dirname, "./lib/**/views/**/*.ex"),
        path.resolve(__dirname, "./lib/**/live/**/*.ex"),
        path.resolve(__dirname, "./assets/js/**/*.js")
    ],
    theme: {
        extend: {},
    },
    variants: {},
    plugins: [],
};
