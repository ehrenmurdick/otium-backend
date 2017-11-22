var _ = require('lodash');

exports.respondWithJsonImpl = function(code, msg) {
  return function() {
    global.res.status(code).json(msg);
  }
}

exports.getRequestBodyImpl = function(nothing, just, key) {
  return function() {
    var value = _.get(global.req.body, key);
    if (value !== undefined && value !== null) {
      return just(value);
    } else {
      return nothing;
    }
  }
}
