var HelloWorld = require('./output/HelloWorld');

exports.helloWorld = (req, res) => {
  global.req = req;
  global.res = res;
  var effect = HelloWorld.handle();
}
