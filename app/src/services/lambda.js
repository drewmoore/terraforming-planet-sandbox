const Lambda = require('aws-sdk/clients/lambda');
const STS = require('aws-sdk/clients/sts');

const initializeLambda = async (lambdaArn) => {
  const lambdaConfig = { region: lambdaArn.split(':')[3] };

  // TODO: comment-out all of this for credentials before presentation.
  const response = await new STS().assumeRole({
    RoleArn: process.env.UNPRIVILEGED_ROLE_ARN,
    RoleSessionName: 'unprivileged',
  }).promise();
  const {
    AccessKeyId: accessKeyId,
    SecretAccessKey: secretAccessKey,
    SessionToken: sessionToken
  } = response.Credentials;

  Object.assign(lambdaConfig, {
    credentials: {
      accessKeyId,
      secretAccessKey,
      sessionToken
    }
  });

  return new Lambda(lambdaConfig);
};

module.exports = { initializeLambda };
