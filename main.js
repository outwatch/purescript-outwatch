var MainModule = require("./output/Example.Launcher/index.js")
if (module.hot) { module.hot.accept(); }
document.getElementById("wrapper").innerHTML = '<div id="app"></div>'
MainModule.main()