exports.send = function(res) {
  return function(code) {
    return function(msg) {
      return function() {
        res.status(code).send(msg);
      }
    }
  }
}
