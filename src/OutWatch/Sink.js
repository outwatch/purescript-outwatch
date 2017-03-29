
var Rx = require('rxjs');

function startWithMany(arr, obs) {
  return arr.reduceRight(function(acc,cur){
    return acc.startWith(cur)
  }, obs)
}

exports.createHandlerImpl = function (arr) {
  var subject = new Rx.Subject()
  var sink = function(value) { return function() { subject.next(value)} }
  return { src : startWithMany(arr, subject) , sink : sink }
}
exports.createHandlerEffImpl = function (arr) {
  return function(){
    var subject = new Rx.Subject()
    var sink = function(value) { return function() { subject.next(value)} }
    return { src : startWithMany(arr, subject) , sink : sink }
  }
}

exports.redirect = function(observerLike) {
  return function(project) {
    var forward = exports.createHandlerImpl([])
    var projected = project(forward.src)
    if (observerLike.src) {
      projected.takeUntil(observerLike.src.ignoreElements().defaultIfEmpty())
        .subscribe(function(s) { observerLike.sink(s)() })
    } else {
      projected.subscribe(function(s) { observerLike.sink(s)() })
    }
    return forward
  }
}

exports.redirect2Impl = function(observerLike) {
  return function(project) {
    return function(createTuple) {
      var b = exports.createHandlerImpl([])
      var c = exports.createHandlerImpl([])
      var projected = project(b.src)(c.src)
      if (observerLike.src) {
        projected.takeUntil(observerLike.src.ignoreElements().defaultIfEmpty())
          .subscribe(function(s) { observerLike.sink(s)() })
      } else {
        projected.subscribe(function(s) { observerLike.sink(s)() })
      }
      return createTuple(b)(c)
    }
  }
}

exports.redirect3Impl = function(observerLike) {
  return function(project) {
    return function(createTuple) {
      var b = exports.createHandlerImpl([])
      var c = exports.createHandlerImpl([])
      var d = exports.createHandlerImpl([])
      var projected = project(b.src)(c.src)(d.src)
      if (observerLike.src) {
        projected.takeUntil(observerLike.src.ignoreElements().defaultIfEmpty())
          .subscribe(function(s) { observerLike.sink(s)() })
      } else {
        projected.subscribe(function(s) { observerLike.sink(s)() })
      }
      return createTuple(b)(c)(d)
    }
  }
}
