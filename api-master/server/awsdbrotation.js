const AWS = require('aws-sdk/');
var config = require('../server/config.json');
const LOGGER = require("log4js").getLogger("awsdbrotation");
const secretName = config.secretName;
const rolearn = config.rolearn;
const region = 'us-east-1';
AWS.config.update({ region: "us-east-1" });

var roleToAssume = {
  RoleArn: rolearn,
  RoleSessionName: "session1",
  DurationSeconds: 900,
};
var sts = new AWS.STS();
let data;
/*
API and DB are hosted in 2 different servers
Here we are getting the seesion credentials required to connect to DB server
using Role ARN 
*/
const getCrossAccountCredentials = async () => {
  return new Promise((resolve, reject) => {
    sts.assumeRole(roleToAssume, (err, data1) => {
      if (err) {reject(err);
        LOGGER.error(err);
      }
      else {
        resolve({
          accessKeyId: data1.Credentials.AccessKeyId,
          secretAccessKey: data1.Credentials.SecretAccessKey,
          sessionToken: data1.Credentials.SessionToken,
        });
      }
    });
  });
}

async function fetchSecurityKeys() {
 if(config.environment!='local'){
  try {

    const accessparams = await getCrossAccountCredentials();
    // here we are passing  the  credentials to DB server to get  secrets
     /*
         Here we are passing  the credentials got from  getCrossAccountCredentials() to connect  to DB server
         and getting secrets manager instance
    */
    const client = new AWS.SecretsManager({
      credentials: accessparams,
      region: region
    });
    //here we are callling serent managerer's get secrets api to get secrets we are passing secret Name parameter
   
    data = await client.getSecretValue({
      SecretId: secretName,
    }).promise();
    if (data) {
      if (data.SecretString) {
        const secretString = data.SecretString;
        const secretObject = JSON.parse(secretString);
        const output = {};
        Object.keys(config.dbhosturls).forEach(ele => {
          //we are replacing username , pswd, host and port
          output[ele] = config.dbhosturls[ele].replace("dbuser", secretObject.username)?.replace("dbpwd", secretObject.password)?.replace("MY_HOST", secretObject.host)?.replace("MY_PORT", secretObject.port);
        })
        data = output;
      }
    }
    
  } catch (e) {
    LOGGER.error("Error while getting DB rotation keys ", e);
  }
  return data;
}else{
  //if not able to get data from aws then we can retrive from config file
 
  return config.dbhosturls;
}
}
module.exports = fetchSecurityKeys;

