'use strict';
const LOGGER = require("log4js").getLogger("Restricteditems");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Restricteditems) {

	Restricteditems.restrictedauditlog = function (data,reqctx) {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		var sql = 'select * from createrestrictedcaseauditlog($1,$2)'
		var params = [data.where.objectid, (data && data.securityuserid?data.securityuserid:suserid)];

		return util.executeDBQuery(sql, params)
			.then(res => {
				return res;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Restricteditems.remoteMethod('restrictedauditlog', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'query'
			},
			required: true
		},{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
		http: {
			verb: 'get'
		},
		returns: {
			type: 'string',
			root: true
		}
	});

	Restricteditems.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Restricteditems.observe('access', (ctx, next) => util.access(ctx, next));
	Restricteditems.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

	Restricteditems.updaterestrictions = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
		
		return Restricteditems.updateAll({
            objectid: request.objectid
            
        }, {
			activeflag: request.activeflag,
            updatedby: request && request.securityuserid?request.securityuserid: _securityusersid
        }).then(data => {
            return data;
        })

	}

	Restricteditems.addrestriction = (request) => {
        const sql = 'select * from cjams.addupdaterestrictedcase($1)';

		request.userids = request.userslist.map(item => item.userid);

        return util.executeDBQuery(sql, [request])
            .then(data => data[0])
            .catch(err => {
				util.logError(err)
			});
	}

	Restricteditems.remoteMethod('updaterestrictions', {
        http: {
            path: '/updaterestrictions',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {
              source: 'context'
            }
          }],
        returns: {
            type: 'object',
            root: true
        }
	});
	
	Restricteditems.remoteMethod('addrestriction', {
        http: {
            path: '/addrestriction',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Restricteditems.remoteMethod('list', {
            http: {
                path: '/list',
                verb: 'get'
            },
            accepts: [{
                arg: 'filter',
                type: 'object',
                http: {
                    source: 'query'
                }
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );

    Restricteditems.list = request => {

        const sql = ` select r.objectid, r.accessuserid as userid, coalesce(r.roletypekey, up.roletypekey) as roletypekey, c.countyid from restricteditems r
                        join v_userprofile up on up.securityusersid = r.accessuserid and r.activeflag = 1
                        join county c on c.countyid = up.countyid and c.activeflag = 1
                        where objectid = $1; `;

        return util.executeDBQuery(sql, [request.where.objectid])
            .then(data => {
                let result = {
                    code : 500,
                    success: false
                }
                if(data.length > 0) {
                    result = {
                        code : 200,
                        success: true,
                        data : {
                            caseworkerlist : data.filter(item => item.roletypekey === 'CWCW'),
                            supervisorlist : data.filter(item => item.roletypekey === 'CWSP'),
                            countylist: data.map(item => item.countyid)
                        }
                    }
                }
                return result;
            })
            .catch(err => {
                util.logError(err)
            });
    }
};
