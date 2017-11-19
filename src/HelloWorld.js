var _ = require('lodash');

exports.send = function(code) {
  return function(msg) {
    return function() {
        global.res.status(code).json(msg);
    }
  }
}

exports.get = function(key) {
  return function() {
    return _.get(global.req.body, key);
  }
}
