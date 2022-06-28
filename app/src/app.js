//const bodyParser = require('body-parser');
const express = require('express');
const logger = require('morgan');

const catch404s = require('./middlewares/catch404s');
const errorHandler = require('./middlewares/errorHandler');
const router = require('./routes');

const app = express();

app.disable('etag');

app.use(logger('dev'));
app.use(router);
app.use(catch404s);
app.use(errorHandler);

// Export your express server so you can import it in the lambda function.
module.exports = app;
