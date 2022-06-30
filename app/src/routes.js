const express = require('express');

const router = express.Router();

router.get('/hello', async (req, res, next) => {
  try {
    const response = { message: `Hello ${req.query.name || 'World'}!` }

    res.send(response);
  } catch (error) {
    next(error);
  }
});

const Lambda = require('aws-sdk/clients/lambda');

const privateLambdaArn = process.env.PRIVATE_LAMBDA_ARN;
const privateLambda = new Lambda({ region: privateLambdaArn.split(':')[3] })

router.get('/private', async (req, res, next) => {
  try {
    const data = await privateLambda.invoke({ FunctionName: privateLambdaArn }).promise();
    const payload = JSON.parse(data.Payload);

    const response = { message: `Hello ${req.query.name || 'World'}! Secret: ${payload.data.number}` }

    res.send(response);
  } catch (error) {
    next(error);
  }
});

module.exports = router;
