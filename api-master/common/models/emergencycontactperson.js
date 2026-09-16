'use strict';
const LOGGER = require("log4js").getLogger("emergencycontactperson");
const util = require('../utils/utils');
const app = require('../../server/server');

module.exports = function(Emergencycontactperson) {
    
    Emergencycontactperson.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Emergencycontactperson.observe('access', (ctx, next) => util.access(ctx, next));
    Emergencycontactperson.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

    Emergencycontactperson.add =  (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var personid = request.personid;
        var emergencycontactperson=request.emergency;
        var prs = [];
        if (Array.isArray(emergencycontactperson)) {
            emergencycontactperson.forEach(emergency => {
                prs.push(app.models.Emergencycontactperson.create({
                    personid: personid,
                    contactpersonid: emergency.contactpersonid,
                    insertedby: (request && request.securityuserid ? request.securityuserid : _securityusersid),
                    updatedby: (request && request.securityuserid ? request.securityuserid : _securityusersid)  
                }).catch(err => LOGGER.error(err))
                )
            });
        }
        return Promise.all(prs);


    }

    Emergencycontactperson.list=(request)=>{
        return app.models.Person.find({
            where: { personid: request.where.personid },
            fields:['personid','firstname','lastname','activeflag'],
            include: [{
                relation: 'emergencycontactperson',
                scope:{
                    fields:['personid']
                    
                }
            }]
        })

    }

    Emergencycontactperson.remoteMethod('add', {
        http: {
            path: '/add',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        returns: {
            type: 'string',
            root: true
        }
    });
    Emergencycontactperson.remoteMethod('list', {
        accepts: {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        },
        http: {
          path: '/list',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });


};
