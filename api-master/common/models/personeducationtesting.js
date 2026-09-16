'use strict';
const LOGGER = require("log4js").getLogger("personeducationtesting");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Personeducationtesting) {

    Personeducationtesting.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {
                  source: 'context'
                }
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Personeducationtesting.remoteMethod('personeducationtestingdelete', {
        http: { 
                path: '/personeducationtestingdelete/:id',
                verb: 'delete'
              },
		accepts:
			  {
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			  },
        returns: 
             {
			    type: 'Object',
			    root: true
		     }
    });

    Personeducationtesting.remoteMethod('list', {
        http: {
              path: '/list',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
      });

    Personeducationtesting.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
		
		request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
	  
        if(request.personeducationtestingid== null || request.personeducationtestingid == undefined)
        {
            return Personeducationtesting.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personeducationtesting.updateAll({personeducationtestingid:request.personeducationtestingid},request);
        }
    };

    Personeducationtesting.personeducationtestingdelete = (id) => {
		var sql = 'update personeducationtesting set activeflag = 0 WHERE personeducationtestingid =\''+id+'\'';
        return util.executeDBQuery(sql, []).then(data => {
			 return data;
	    }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personeducationtesting.list = request => {
        let gPersontestinginfo = [];
        const personid  = request.where.personid;
        const testinginfotype  = request.where.testinginfotype;
        if (testinginfotype =='Basic')
        {
            return Personeducationtesting.find({
                where: {personid: personid,testinginfotype: testinginfotype},
                fields:['personeducationtestingid','personid','testinginfotype','readinglevel','readingtestdate','mathlevel','mathtestdate']
            })
            .then(data => {
                gPersontestinginfo = JSON.parse(JSON.stringify(data));
                return Promise.all(gPersontestinginfo);
            })
            .then(data => data)
            .catch(err => util.logError(err));
        }
        else if (testinginfotype =='Advanced')
        {
            return Personeducationtesting.find({
                where: {personid: personid,testinginfotype: testinginfotype},
                fields :['personeducationtestingid','personid','testinginfotype','testingtypekey','nameoftester','pretestdate','pretestscore','posttestdate','posttestscore','testingprovider'],
                include: [{
                    relation: 'testingtype',
                    scope: {
                        fields: ['testingtypekey', 'typedescription','ishighergrade','displayorder']
                    }
                }]
            })
            .then(data => {
                gPersontestinginfo = JSON.parse(JSON.stringify(data));
                return Promise.all(gPersontestinginfo);
            })
            .then(data => data)
            .catch(err => util.logError(err));
        }
          return Promise.resolve([]);
      };

    Personeducationtesting.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personeducationtesting.observe('access', (ctx, next) => util.access(ctx, next));
    Personeducationtesting.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
