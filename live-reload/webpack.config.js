const { resolve } = require('path');
const webpack = require('webpack');

// https://github.com/webpack/docs/wiki/webpack-dev-server
module.exports = {
  entry: ['./example.js'],
  output: {
    filename: '[name].js',
    path: resolve(__dirname, 'dist'),
  },
  devServer: {
    hot: true, // enable HMR on the server
    contentBase: resolve(__dirname, 'dist'), // match the output path
  },

  plugins: [
    // split all but Example and OutWatch in a vendor plugin
    // for faster reload
    new webpack.optimize.CommonsChunkPlugin({
        name: 'vendor',
        minChunks: function (module) { 
          return (module.context.indexOf('output/Example') == -1)
          //  && (module.context.indexOf('output/OutWatch') == -1)
        }
    }),
    
    // since there are no more common modules between them we end up with 
    // just the runtime code included in the manifest file
    new webpack.optimize.CommonsChunkPlugin({name: 'manifest'}),

    // prints more readable module names in the browser console on HMR updates
    new webpack.NamedModulesPlugin(),
  ],
};