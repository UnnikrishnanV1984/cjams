'use strict';
const LOGGER = require("log4js").getLogger("awsapiKeys");
const util = require('../utils/utils');
var app = require('../../server/server');


module.exports = function (AwsapiKeys) {

    AwsapiKeys.remoteMethod('getWebAwsSecretsManager', {
        accepts: [{
            arg: 'filter',
            type: 'object',
            required: false

        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        http: {
            path: '/getWebAwsSecretsManager',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });


    AwsapiKeys.getWebAwsSecretsManager = async function (request, reqctx) {

       const result=app.get('apiKeys'); //here we are geting api keys from app

        if(!result){
            const err = new Error('AWS secrets configuration not found');
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        }

        const safeResult = util.getWebSafeAwsConfig(result);
        return util.encryptresponse(safeResult);
    }
}