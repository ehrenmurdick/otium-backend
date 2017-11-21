var _ = require('lodash');

function unwrapValue0(pursVal) {
  if (_.keys(pursVal).length === 1 && _.has(pursVal, "value0")) {
    return pursVal.value0;
  } else {
    return pursVal;
  }
}

exports.respondWithJsonImpl = function(code, msg) {
  return function() {
    global.res.status(code).json(unwrapValue0(msg));
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
