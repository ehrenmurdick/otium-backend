exports.send = function(code) {
  return function(msg) {
    return function() {
      return function(res) {
        res.status(code).json(msg);
      }
    }
  }
}
