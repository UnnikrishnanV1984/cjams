'use strict';

var app = require('../../server/server');
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("casereview");

module.exports = function(Casereview) {
    
	// Casereview add/update 
    Casereview.addupdate = (request, reqctx) => {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  		
        var securityuserid =(request && request.securityuserid?request.securityuserid: _securityusersid);
        var personid = request.personid;

        var sql = "select * from casereviewaddupdate($1,$2, $3)"

        return util.executeDBQuery(sql, [personid, request, securityuserid])
          .then(res => {
            return res
          })
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Casereview.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ],
        returns: {
            type : 'string',
            root : true
        }
    });
    
     // casereview list
     Casereview.list = function (data) {
		
		var sql = 'select * from getcasereviewlist()'

		return util.executeSecondaryNodeDBQuery(sql, []).then((_data) => {

				return _data;
			}).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
	};
	
	Casereview.remoteMethod('list', {
		accepts: [{
            arg: 'filter',
            type: 'object',
            required: false

        }],
        http: {
			verb: 'get'
		},
		returns: {
			type: 'Object',
			root: true
		}
    });
    
    // fetch case review based on casereview is
Casereview.fetchCasereviewbycaseid = function (data) {
		
		var sql = 'select * from fetchCasereviewbycaseid($1)'

		return util.executeSecondaryNodeDBQuery(sql, [data.where.caseid]).then((_data) => {

				return _data;
			}).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
	};
	
	Casereview.remoteMethod('fetchCasereviewbycaseid', {
		accepts: {
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'query'
			},
			required: true
		},
		http: {
			verb: 'get'
		},
		returns: {
			type: 'Object',
			root: true
		}
	});

    Casereview.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Casereview.observe('access', (ctx, next) => util.access(ctx, next));
    Casereview.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
