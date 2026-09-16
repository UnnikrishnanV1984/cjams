'use strict';
const LOGGER = require("log4js").getLogger("adoptioncasesuspension");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const adoptionsuspensionstr = 'Adoption Case Suspension Submitted for review';
const routingintakesql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';

module.exports = function (Adoptioncasesuspension) {
    Adoptioncasesuspension.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
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

    Adoptioncasesuspension.addupdate = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        return Adoptioncasesuspension.addcasesuspension(request, _securityusersid);
    }

    Adoptioncasesuspension.addcasesuspension = function (request, _securityusersid) {
        var securityusersid = _securityusersid;
        var v_adoptionsuspensionid;
        var revisionObj = {};
        if (request.adoptionsuspensionid === undefined || request.adoptionsuspensionid == null) {
            
            return Adoptioncasesuspension.create({
                adoptionagreementid: request.adoptionagreementid,
                adoptioncaseid: request.adoptioncaseid,
                transactiondate: new Date().toLocaleString(),
                suspensionreasontypekey: request.suspensionreasontypekey,
                suspensionbegindate: request.suspensionbegindate,
                suspensionenddate: request.suspensionenddate,
                suspensionremarks: request.suspensionremarks,
                insertedby:securityusersid,
				updatedby: securityusersid,
                approvalstatustypekey: '3045'
            }).then(data => {
        
                revisionObj.adoptionagreementid= request.adoptionagreementid;
                revisionObj.adoptioncaseid= request.adoptioncaseid;
                revisionObj.transactiondate= new Date().toLocaleString();
                revisionObj.suspensionreasontypekey= data.suspensionreasontypekey;
                revisionObj.suspensionbegindate= data.suspensionbegindate;
                revisionObj.suspensionenddate= data.suspensionenddate;
                revisionObj.suspensionremarks= data.suspensionremarks;
                revisionObj.insertedby= securityusersid;
                revisionObj.activeflag=request.activeflag;
                revisionObj.updatedby=_securityusersid;
                revisionObj.approvalstatustypekey='3045';
                revisionObj.adoptionsuspensionid=data.adoptionsuspensionid;
                app.models.Adoptioncasesuspensionrevision.create(revisionObj).then(
                  resp=>{ 
                    v_adoptionsuspensionid = data.adoptionsuspensionid;
            
                    var status = 15;
                    var nofitymsg = adoptionsuspensionstr;
                    var routeddescription = adoptionsuspensionstr;
                    if (request.servicecaseid == null || request.servicecaseid === undefined) {
                        request.servicecaseid = '';
                    }
                    var sql = routingintakesql;
                    util.executeDBQuery(sql, [v_adoptionsuspensionid, securityusersid, 'ADSR', status, nofitymsg, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1])
                    .then((resp1)=>{
                        LOGGER.info(resp1);
                    }).catch(err=>{
                        LOGGER.error(err);
                        throw err;
                    });
                   }                        
                  );
                  return data;
                }).catch(err => util.logError(err));

        } else {
            
            var sql2 = 'UPDATE adoptioncasesuspensionrevision SET activeflag=0 WHERE adoptionsuspensionid = $1';

            util.executeDBQuery(sql2, [request.adoptionsuspensionid])
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

            revisionObj.adoptionagreementid= request.adoptionagreementid;
            revisionObj.adoptioncaseid= request.adoptioncaseid;
            revisionObj.transactiondate= new Date().toLocaleString();
            revisionObj.uspensionreasontypekey= request.suspensionreasontypekey;
            revisionObj.suspensionbegindate= request.suspensionbegindate;
            revisionObj.suspensionenddate= request.suspensionenddate;
            revisionObj.suspensionremarks= request.suspensionremarks;
            revisionObj.activeflag=request.activeflag;
            revisionObj.updatedby=_securityusersid;
            revisionObj.approvalstatustypekey='3045';
            revisionObj.adoptionsuspensionid=request.adoptionsuspensionid;

            return app.models.Adoptioncasesuspensionrevision.create(revisionObj).then(resp=>{ 
                v_adoptionsuspensionid = request.adoptionsuspensionid;
                var status = 15;
                var nofitymsg = adoptionsuspensionstr;
                var routeddescription = adoptionsuspensionstr;
                if (request.servicecaseid == null || request.servicecaseid === undefined) {
                    request.servicecaseid = '';
                }
                var sql = routingintakesql;
                util.executeDBQuery(sql, [v_adoptionsuspensionid, securityusersid, 'ADSR', status, nofitymsg, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1])
                .then((resp1)=>{
                    LOGGER.info(resp1);
                }).catch(err=>{
                    LOGGER.error(err);
                    throw err;
                });
            });
        }    
    }

    Adoptioncasesuspension.updatesuspension = (request, _securityusersid) => {
        var securityusersid = (request?.securityuserid ? request.securityuserid : _securityusersid);
        var v_adoptionsuspensionid;
        var comments = '';
        if (request.comments !== undefined && request.comments !== null)
            {comments = request.comments;}
        /*else
            {comments = '';}*/
        if (request.servicecaseid == null || request.servicecaseid === undefined) {          //Sonarqube moved this to the top to reduce complexity
            request.servicecaseid = '';
        }
        return Adoptioncasesuspension.updateAll(
            { adoptionsuspensionid: request.adoptionsuspensionid },
            {
                suspensionreasontypekey: request.suspensionreasontypekey,
                suspensionbegindate: request.suspensionbegindate,
                suspensionenddate: request.suspensionenddate,
                suspensionremarks: request.suspensionremarks,
                updatedby: securityusersid
            }).then(data => {
            
            revisionObj.adoptioncaseid= data.adoptioncaseid;
            revisionObj.transactiondate= new Date().toLocaleString();
            revisionObj.suspensionreasontypekey= data.suspensionreasontypekey;
            revisionObj.suspensionbegindate= data.suspensionbegindate;
            revisionObj.suspensionenddate= data.suspensionenddate;
            revisionObj.suspensionremarks= data.suspensionremarks;
            revisionObj.insertedby= securityusersid;
            revisionObj.activeflag=request.activeflag;
            revisionObj.insertedby=securityusersid;
            revisionObj.adoptionsuspensionid=data.adoptionsuspensionid;
            revisionObj.approvalstatustypekey='3045';
            app.models.Adoptioncasesuspensionrevision.create(revisionObj).then(
              resp=>{


                v_adoptionsuspensionid = data.adoptionsuspensionid;
                var status = 15;
                var nofitymsg = adoptionsuspensionstr;
                var routeddescription = adoptionsuspensionstr;
                var sql = routingintakesql;
                return util.executeDBQuery(sql, [v_adoptionsuspensionid, securityusersid, 'ADSR', status, comments, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1])
                    .then(data1 => data1[0].routingintake);
              });
            }).then(resps => 'UPDATED SUCCESSFULLY').catch(err => util.logError(err)); 
    }

    Adoptioncasesuspension.remoteMethod('getsuspensionhistory', {
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
            type: 'string',
            root: true
        }
    });

    Adoptioncasesuspension.getsuspensionhistory = request => {
        var pageno = request.page;
        var pagesize = request.limit;
        var adoptioncaseid = request.where.adoptioncaseid ? request.where.adoptioncaseid : null;
        const sql = 'select * from getadoptioncasesuspensionhistory($1, $2, $3)';
        return util.executeDBQuery(sql, [adoptioncaseid, pageno, pagesize])
            .then(resp => resp)
            .catch(err => err);
    }



    Adoptioncasesuspension.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptioncasesuspension.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptioncasesuspension.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
