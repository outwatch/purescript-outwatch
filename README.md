# OutWatch - Functional, reactive and type safe UIs
[![Build Status](https://travis-ci.org/OutWatch/purescript-outwatch.svg?branch=master)](https://travis-ci.org/OutWatch/purescript-outwatch) [![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/OutWatch/Lobby)

## Getting started

First you will need to install purescript and pulp if you haven't already.
Then run the following commands to install OutWatch.

    $ bower install purescript-outwatch
    $ npm install rxjs snabbdom

And you're done, you can now start building your own OutWatch app!
Please check out the [documentation](https://outwatch.github.io/) on how to proceed.


## Three main goals of OutWatch

1. Updating DOM efficiently without sacrificing abstraction => Virtual DOM
2. Handling subscriptions automatically
3. Removing or restricting the need for Higher Order Observables

## Examples

All examples are located in folder [`examples`](https://github.com/OutWatch/purescript-outwatch/tree/master/examples):

- [`counter`](https://github.com/OutWatch/purescript-outwatch/tree/master/examples/counter)
- [`counter-store`](https://github.com/OutWatch/purescript-outwatch/tree/master/examples/counter-store)
- [`bmi-calculator`](https://github.com/OutWatch/purescript-outwatch/tree/master/examples/bmi-calculator)

## Run tests

```bash
npm install
npm test
```

## OutWatch Live-reload capabilities

to configure fast live reloading with hot module replacement for included examples, just:

  1. clone this repo and install deps
  
    ```shell
    npm install
    pulp build
    ```
  
  2. start webpack-dev-server
  
    ```shell
    ./node_modules/webpack-dev-server/bin/webpack-dev-server.js --inline --hot
    ```
  
  3. open `http://localhost:8080/`
  
  4. start `pscid`

    ```shell 
    pscid # you can install it with npm i -g pscid
    ```

  5. Edit one of the examples
  
  As soon as the module has been recompiled (via pscid, or your ide plugin),
  The webpage is updated with the new app.


to understand the setup, check 

 - [main.js](main.js)
 - [webpack.config.js](webpack.config.js)


## Bugs and Feedback

For bugs, questions and discussions please use the [Github Issues](https://github.com/OutWatch/purescript-outwatch/issues).

## LICENSE

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
