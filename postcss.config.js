module.exports = {
    plugins: [
        require('autoprefixer'),
        require("@tailwindcss/jit")("./tailwind.config.js")
    ]
  }