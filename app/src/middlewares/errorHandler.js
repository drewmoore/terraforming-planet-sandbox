const errorHandler = async (err, req, res, next) => {
  err.status = err.status || 500;

  console.log('There was an error: ', err.status, err.name, err.message);

  res.status(err.status).send({ error: err });
};

module.exports = errorHandler;
