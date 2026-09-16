const AWS = require('aws-sdk');
var config = require('../server/config.json');
const LOGGER = require("log4js").getLogger("getapikeys");

AWS.config.update({ region: "us-east-1" });

async function fetchSecrets() {
    let data ={};
    if(config.environment !='local'){
        try{
            const secretName = config.apiSecretName;
            //we are geting  AWS Secrets for api and web
            data = await new AWS.SecretsManager().getSecretValue({ SecretId: secretName }).promise();
            return JSON.parse(data?.SecretString);
        }

        catch (e) {
            LOGGER.error("error whle getting API and web from Secrets Manager", e);
        }
       

    }
    else{
        data = config.smLocalValues;
    }

    return data;
}
module.exports = fetchSecrets;