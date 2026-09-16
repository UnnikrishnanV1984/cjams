'use strict';
const LOGGER = require("log4js").getLogger("visitationlog");
const util = require('../utils/utils');
var app = require('../../server/server');
var config = require('../../server/config.json');


module.exports = function (Visitationlog) {

    Visitationlog.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Visitationlog.observe('access', (ctx, next) => util.access(ctx, next));
    Visitationlog.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

    Visitationlog.addupdate = (request,reqctx) => {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        const insertedon = new Date().toLocaleString();
        if (!request.visitationlogid) {
            request.insertedby = suserid;
            request.insertedon = insertedon;
            request.updatedby = suserid;
            request.updatedon = insertedon;
            request.activeflag = true; //????????????
            return Visitationlog.create(request).then(res => {
                //with the returned id, add to clients
                request.visitationlogid = res.visitationlogid;
                if (request.visitationlogclient && request.visitationlogclient.length > 0) {
                    request.visitationlogclient.forEach(element => {
                        const vpclientsreq = {};
                        vpclientsreq.personid = element;
                        vpclientsreq.visitationlogid = res.visitationlogid;
                        return app.models.Visitationlogclient.create(vpclientsreq).then(res1 => {
                            LOGGER.debug(res1);
                        })
                    });
                }
                if (request.collaterallist && request.collaterallist.length > 0) {
                    request.collaterallist.forEach(element => {
                        const collateralsreq = {};
                        collateralsreq.collateralid = element;
                        collateralsreq.visitationlogid = res.visitationlogid;
                        return app.models.Visitationlogclient.create(collateralsreq).then(res2 => {
                            LOGGER.debug(res2);
                        })
                    });
                }
                return res;
            })
        }
        else {
            return Visitationlog.updatevisitationlog(request,reqctx);
        }
    };

    Visitationlog.updatevisitationlog = (request,reqctx) => {
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        const visitationlogid = request.visitationlogid;
        const id = request && request.securityuserid ? request.securityuserid: suserid;
        var sql = 'UPDATE Visitationlog SET activeflag=0, updatedby = $1, updatedon = now() WHERE visitationlogid = $2';

        return util.executeDBQuery(sql, [id,visitationlogid])
        .then (data => {
            request.visitationlogid = null;
            return Visitationlog.addupdate(request);
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Visitationlog.listallvisitationlogs = request => {  // NOSONAR
        const pageno = request.page;
        const pagesize = request.limit;
        const sortdir = request.where.sortdirection;
        const sortcolumn = request.where.sortcolumn;
        const iscaseexpunged  = request.where.iscaseexpunged ?? 0;
        var totalCount = 0;
        const sql = 'select * from getallvisitationlogs($1,$2,$3,$4,$5,$6,$7)';
        return util.executeSecondaryNodeDBQuery(sql, [request.where.caseid, pageno, pagesize, sortdir,sortcolumn,request.where.isExpungementSuperUser, iscaseexpunged])
            .then(data => {
                if (data.length>0) {
					if(data[0].getallvisitationlogs!=null && data[0].getallvisitationlogs.length>0){
					totalCount= data[0].getallvisitationlogs[0].totalcount;}
				}
				var result;
				  result = {
				  'data' : data[0].getallvisitationlogs,
				  'count' : totalCount
				  };
                return result;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Visitationlog.deletevisitationlog = (request,reqctx) => {
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        const sql = 'select * from deletevisitationlog($1, $2)';
        return util.executeDBQuery(sql, [request.visitationlogid,  (request && request.securityuserid?request.securityuserid: suserid)])
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };


    Visitationlog.remoteMethod('listallvisitationlogs', {
        http: {
            path: '/listallvisitationlogs',
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

    Visitationlog.remoteMethod('addupdate', {
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
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Visitationlog.remoteMethod('deletevisitationlog', {
        http: {
            path: '/deletevisitationlog',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
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
