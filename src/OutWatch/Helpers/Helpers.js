exports.debug = function(a){
    return function() {
        console.log(a)
    }
}