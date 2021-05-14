module.exports = {
    mode: 'jit',
    purge:  [
        "../**/*.html.eex",
        "../**/*.html.leex",
        "../**/views/**/*.ex",
        "../**/live/**/*.ex",
        "./js/**/*.js"
    ],
    theme: {
        extend: {},
    },
    variants: {},
    plugins: [],
}
