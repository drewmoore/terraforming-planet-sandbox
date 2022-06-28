const url = require('url');

const catch404s = (req, res, next) => {
  const err = new Error(`No path exists for ${req.pathname}`);
  err.status = 404;

  next(err);
};

module.exports = catch404s;
