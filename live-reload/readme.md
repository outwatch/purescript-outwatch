# OutWatch Live-reload capabilities

this examples show how to setup a fast ( < 0.5 s ) live-reload with hot module replacement.

1. start webpack-dev-server

```shell
cd live-reload
../node_modules/webpack-dev-server/bin/webpack-dev-server.js --inline --hot
```

2. visit `http://localhost:8080/`

3. Edit one of the examples

As soon as the module has been recompiled (via pscid, or your ide plugin),
The webpage is updated with the new app.