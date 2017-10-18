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



exports.newSingle = window.SingleRef


exports.put = function(a) {
  return function(ref){
    return function() {
      window.SingleRef.value = a;
    }
  }
}


exports.get = function(ref) {
  return function(){
    return window.SingleRef.value;
  }
}

exports.update = function(f) {
  return function(ref){
    return function() {
      window.SingleRef.value = f(window.SingleRef.value);
      return window.SingleRef.value;
    }
  }
}
