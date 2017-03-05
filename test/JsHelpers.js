exports.stringify = JSON.stringify

exports.newEvent = function(str) {
  return new Event(str)
}
