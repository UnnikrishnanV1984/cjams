'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const adoptionrevisionstr = 'Adoption Suspension Revision Submitted for review';
module.exports = function (Adoptioncasesuspensionrevision) {

    Adoptioncasesuspensionrevision.remoteMethod('addupdate', {
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

    Adoptioncasesuspensionrevision.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        } 
        if (request.adoptionsuspensionrevisionid !== undefined && request.adoptionsuspensionrevisionid !== null) {
            return Adoptioncasesuspensionrevision.updatesuspensionrevision(request, _securityusersid);
        } else {
            return Adoptioncasesuspensionrevision.addsuspensionrevision(request, _securityusersid);
        }
    }

    Adoptioncasesuspensionrevision.addsuspensionrevision = function (request, _securityusersid) {
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var v_adoptionsuspensionrevisionid;
        var comments;
        if (request.comments !== undefined && request.comments !== null)
            {comments = request.comments;}
        else
            {comments = '';}
        return Adoptioncasesuspensionrevision.create({
            adoptionagreementid: request.adoptionagreementid,
            adoptionplanningid: request.adoptionplanningid,
            transactiondate: new Date().toLocaleString(),
            suspensionreasontypekey: request.suspensionreasontypekey,
            suspensionbegindate: request.suspensionbegindate,
            suspensionenddate: request.suspensionenddate,
            suspensionremarks: request.suspensionremarks,
            insertedby: securityusersid,
            updatedby: securityusersid
        }).then(data => {
            v_adoptionsuspensionrevisionid = data.adoptionsuspensionrevisionid;
            var status = 15;
            var nofitymsg = adoptionrevisionstr;
            var routeddescription = adoptionrevisionstr;
            if (request.servicecaseid == null && request.servicecaseid === undefined) {
                request.servicecaseid = '';
            }
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
            return util.executeDBQuery(sql, [v_adoptionsuspensionrevisionid, securityusersid, 'ADSR', status, comments, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1])
                .then(data1 => data1[0].routingintake);
        }).then(resp => {
            var responseJson = {};
            responseJson.adoptionsuspensionrevisionid = v_adoptionsuspensionrevisionid;
            return responseJson;
        }).catch(err => util.logError(err));
    }

    Adoptioncasesuspensionrevision.updatesuspensionrevision = (request, _securityusersid) => {
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var v_adoptionsuspensionrevisionid;
        var comments;
        if (request.comments !== undefined && request.comments !== null)
            {comments = request.comments;}
        else
            {comments = '';}
        return Adoptioncasesuspensionrevision.updateAll(
            { adoptionsuspensionrevisionid: request.adoptionsuspensionrevisionid },
            {
                suspensionreasontypekey: request.suspensionreasontypekey,
                suspensionbegindate: request.suspensionbegindate,
                suspensionenddate: request.suspensionenddate,
                suspensionremarks: request.suspensionremarks,
                updatedby: securityusersid
            }).then(updatedData => {
                v_adoptionsuspensionrevisionid = updatedData.adoptionsuspensionrevisionid;
                var status = 15;
                var nofitymsg = adoptionrevisionstr;
                var routeddescription = adoptionrevisionstr;
                if (request.servicecaseid == null && request.servicecaseid === undefined) {
                    request.servicecaseid = '';
                }
                var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
                return util.executeDBQuery(sql, [v_adoptionsuspensionrevisionid, securityusersid, 'ADSR', status, comments, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1])
                    .then(data1 => data1[0].routingintake);
            }).then(resps => 'UPDATED SUCCESSFULLY').catch(err => util.logError(err));
    }

    Adoptioncasesuspensionrevision.remoteMethod('getsuspensionhistory', {
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

    Adoptioncasesuspensionrevision.getsuspensionhistory = request => {
        var pageno = request.page;
        var pagesize = request.limit;
        var adoptioncaseid = request.where.adoptioncaseid ? request.where.adoptioncaseid : null;
        const sql = 'select * from getadoptioncasesuspensionhistory($1, $2, $3)';
        return util.executeDBQuery(sql, [adoptioncaseid, pageno, pagesize])
            .then(resp => resp)
            .catch(err => err);
    }
  

    Adoptioncasesuspensionrevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptioncasesuspensionrevision.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptioncasesuspensionrevision.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}