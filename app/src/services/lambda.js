const Lambda = require('aws-sdk/clients/lambda');
const STS = require('aws-sdk/clients/sts');

const initializeLambda = async (lambdaArn) => {
  const lambdaConfig = { region: lambdaArn.split(':')[3] };
  const roleArn = process.env.UNPRIVILEGED_ROLE_ARN;

  if (roleArn && roleArn.length) {
    const response = await new STS().assumeRole({
      RoleArn: roleArn,
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
  }

  return new Lambda(lambdaConfig);
};

module.exports = { initializeLambda };
