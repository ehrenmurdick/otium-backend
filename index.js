var HelloWorld = require('./output/HelloWorld');

exports.helloWorld = (req, res) => {
  HelloWorld.handle(res)();
}
