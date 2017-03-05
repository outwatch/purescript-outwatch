exports.empty = {}

exports.success = function(promise){
  return function(a) {
    return function() {
      promise.value = a
    }
  }
}

exports.foreach = function(promise) {
  return function(callback){
    return function () {
      if (promise.value){
        var x = callback(promise.value)
        console.log(x)
        callback()
      }
    }
  }
}
