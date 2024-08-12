const path = require('path');
module.exports = {
  mode: 'development', // または 'production' に設定
  entry: './app/javascript/packs/application.js',
  output: {
    path: path.resolve(__dirname, 'public/packs'),
    filename: 'bundle.js',
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      }
    ]
  },
  resolve: {
    extensions: ['.js', '.jsx', '.css']
  },
  devtool: 'source-map'
};
