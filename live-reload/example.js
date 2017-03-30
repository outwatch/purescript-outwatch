var MainModule = require("../output/Ok/index.js")
if (module.hot) { module.hot.accept(); console.log("%% accepted") }
document.getElementById("wrapper").innerHTML = '<div id="app"></div>'
MainModule.main()