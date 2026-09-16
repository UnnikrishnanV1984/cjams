'use strict';
const LOGGER = require("log4js").getLogger("courtnumbers");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Courtnumbers) {

    Courtnumbers.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Courtnumbers.observe('access', (ctx, next) => util.access(ctx, next));
    Courtnumbers.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

    Courtnumbers.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const insertedon = new Date().toLocaleString();
        if (request.courtnumberid == undefined || request.courtnumberid == null) {
            request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.insertedon = insertedon;
            request.activeflag = true; //????????????
            return Courtnumbers.create(request);
        }
        else {
            return Courtnumbers.updatecourtnumber(request, reqctx);
        }
    };

    Courtnumbers.updatecourtnumber = (request, reqctx) => {
        var sql = 'UPDATE Courtnumbers SET activeflag=0 WHERE courtnumberid =\'' + request.courtnumberid + '\'';
        return util.executeDBQuery(sql, [])
            .then(() => {
                request.courtnumberid = null;
                return Courtnumbers.addupdate(request, reqctx);
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

   Courtnumbers.listallcourtnumbers = request => {

            const sql = 'select * from listallcourtnumbers($1)';
            return util.executeSecondaryNodeDBQuery(sql, [request.where.caseid])
            .then((data) => {
                return data && data.length > 0 ? data[0].listallcourtnumbers : null;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };


    Courtnumbers.deletecourtnumber = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const sql = 'select * from deletecourtnumber($1, $2)';
        return util.executeDBQuery(sql, [request.courtnumberid,  (request && request.securityuserid?request.securityuserid: _securityusersid)])
            .then(data => data)
            .catch(err => util.logError(err));
    };


    Courtnumbers.remoteMethod('listallcourtnumbers', {
        http: {
            path: '/listallcourtnumbers',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'Object',
            root: true
        }
    });

    Courtnumbers.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
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
			http: {source: 'context'}
		  }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Courtnumbers.remoteMethod('deletecourtnumber', {
        http: {
            path: '/deletecourtnumber',
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
			http: {source: 'context'}
		  }],
        returns: {
            type: 'object',
            root: true
        }
    });


}