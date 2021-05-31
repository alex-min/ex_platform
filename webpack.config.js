/* eslint-env node */

const path = require("path");
const glob = require("glob");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = (_env, options) => {
  const devMode = options.mode !== "production";
  process.env["NODE_ENV"] = devMode ? "development" : "production";

  return {
    optimization: {
      usedExports: true,
      minimizer: [
        new TerserPlugin({
          parallel: true,
          terserOptions: { sourceMap: devMode },
        }),
        new CssMinimizerPlugin({}),
      ],
    },
    entry: {
      app: glob.sync("./assets/vendor/**/*.js").concat(["./assets/js/app.js"]),
    },
    output: {
      filename: "[name].js",
      path: path.resolve(__dirname, "./priv/static/js"),
      publicPath: "/js/",
    },
    devtool: devMode ? "eval-cheap-module-source-map" : undefined,
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: "babel-loader",
          },
        },
        {
          test: /\.css$/,
          use: [MiniCssExtractPlugin.loader, "css-loader", "postcss-loader"],
        },
        {
          test: /\.scss$/,
          use: [
            MiniCssExtractPlugin.loader,
            "css-loader",
            "sass-loader",
            "postcss-loader",
          ],
        },
      ],
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: "../css/app.css" }),
      new CopyWebpackPlugin({
        patterns: [{ from: "assets/static/", to: "../" }],
      }),
    ],
  };
};
