const express = require('express');
const { initializeLambda } = require('./services/lambda');

const router = express.Router();

router.get('/hello', async (req, res, next) => {
  try {
    const response = { message: `Hello ${req.query.name || 'World'}!` }

    res.send(response);
  } catch (error) {
    next(error);
  }
});


const privateLambdaArn = process.env.PRIVATE_LAMBDA_ARN;
let privateLambda;
initializeLambda(privateLambdaArn).then((l) => { privateLambda = l; });

router.get('/private', async (req, res, next) => {
  try {
    const data = await privateLambda.invoke({ FunctionName: privateLambdaArn }).promise();
    const payload = JSON.parse(data.Payload);
    const body = JSON.parse(payload.body);

    const response = { message: `Hello ${req.query.name || 'World'}! Secret: ${body.data.number}` }

    res.send(response);
  } catch (error) {
    next(error);
  }
});

module.exports = router;
