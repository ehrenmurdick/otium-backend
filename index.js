var HelloWorld = require('./output/HelloWorld');

exports.helloWorld = (req, res) => {
  var effect = HelloWorld.handle(req.body)();
  effect(res);
}
