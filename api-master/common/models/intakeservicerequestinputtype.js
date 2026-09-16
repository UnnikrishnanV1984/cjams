'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestinputtype");
const util = require('../utils/utils');
let app = require('../../server/server');

module.exports = function(Intakeservicerequestinputtype) {
 
    Intakeservicerequestinputtype.list = (request, reqctx) => {
        var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		}  
        var teamtypekey = 'CW' ;
        const sql =     'Select * from getcommunicationtype($1)';
		return util.executeDBQuery(sql, [teamtypekey])
		.then(data => data)
		.catch(err => util.logError(err));
    };

    Intakeservicerequestinputtype.remoteMethod('list', {
        accepts : [{
                arg: 'filter',
                type: 'Object',
                required: false,
                http: {source: 'query'}
            },
            {arg: 'reqctx', type: 'object',
			http: {source: 'context'}}],
        http: {"verb": "get", "path": "/list"},
        returns : {
            type : 'Object',
            root : true
        }
    });

     
    Intakeservicerequestinputtype.listcw = (request) => {
        const teamtypekey = 'CW';
        const sql = 'Select * from getcommunicationtype($1)';
		return util.executeDBQuery(sql, [teamtypekey])
		.then(data => data)
		.catch(err => util.logError(err));
    };

    Intakeservicerequestinputtype.remoteMethod('listcw', {
        accepts : [{
                arg: 'filter',
                type: 'Object',
                required: false,
                http: {source: 'query'}
            }],
        http: {"verb": "get", "path": "/listcw"},
        returns : {
            type : 'Object',
            root : true
        }
    });

    Intakeservicerequestinputtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestinputtype.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestinputtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};