'use strict';
const LOGGER = require("log4js").getLogger("county");
var app = require('../../server/server');
const util = require('../utils/utils');
var config = require('../../server/config.json');

module.exports = function(County) {
	County.countylist = (request) => {
		return County.find({
			where: request.where,
            order: request.order,
            nolimit: request.nolimit,
		}).catch(err => util.logError(err));	
	};

	County.remoteMethod('countylist', {
		http: {
			path: '/countylist',
			verb: 'post'
		},
		accepts: [
			{ arg: 'request', type: 'object', http: { source: 'body' } }],
		returns: {
			type : 'object',
				root : true
		}
	});

	County.list = function(request) {
		var sql = "SELECT DISTINCT CountyName FROM County ORDER BY CountyName";
		return util.executeSecondaryNodeDBQuery(sql, []).then((data) => {
				return data;
		}).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });

	};

	County.regionlist = function(request) {
		var sql = "SELECT DISTINCT APSRegion FROM County WHERE APSRegion IS NOT NULL ORDER BY APSRegion";
		return util.executeSecondaryNodeDBQuery(sql, []).then((data) => {
				return data;
		}).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });

	};



	County.remoteMethod ('list',{
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

	County.remoteMethod ('regionlist',{
		accepts : {
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

	County.remoteMethod('getusercounty', {
        http: { path: '/getusercounty', verb: 'get' },
        accepts: [
            { arg: 'data', type: 'object', http: { source: 'query' } }, {
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  }
        ],
        returns: { type: 'object', root: true }
    });
      County.getusercounty = function (request, reqctx) {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var sql = 'select distinct c.* from cjams.userprofile up ' +
					'join cjams.teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1 ' +
					'join cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1 ' +
					'join cjams.team t on t.teamid = tm.teamid and t.activeflag = 1 ' +
					'join cjams.county c on c.countyid::character varying = t.countyid and c.activeflag = 1 ' +
					'where up.securityusersid = $1 ' +
					'order by c.countyname';

        return util.executeSecondaryNodeDBQuery(sql, [securityusersid])
            .then(data => {
                return data;
            })
            .catch(err => {
               LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    }

	County.remoteMethod('getcountygoliveconfig', {
		accepts: {
		  arg: 'filter',
		  type: 'Object',
		  http: {
			source: 'query'
		  },
		  required: true
		},
		http: {
		  path: '/getcountygoliveconfig',
		  verb: 'get'
		},
		returns: {
		  type: 'Object',
		  root: true
		}
	  });

	County.getcountygoliveconfig = function (request) {

		let sql = 'select * from cjams.countygoliveconfig where objecttype in ($1) and activeflag=1';
		let objecttype =request.where.objecttype ?request.where.objecttype :null;
	
		return util.executeSecondaryNodeDBQuery(sql, [objecttype]).then((data) => {
			return data;
		}).catch((err) => { return util.logError(err).then(() => { throw err; }); });
	
	  };
	County.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	County.observe('access', (ctx, next) => util.access(ctx, next));
	County.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};