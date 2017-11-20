var HelloWorld = require('./output/HelloWorld');

function mkHandleFun(m) {
  return function(req, res) {
    global.req = req;
    global.res = res;
    m.handle();
  }
}

exports.helloWorld = mkHandleFun(require('./output/HelloWorld'));
