'use strict';
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("adoptionsuspensionrevision");
var server = require('../../server/server');
var app = require('../../server/server');
var adoptionrevisionstr = 'Adoption Suspension Revision Submitted for review';
module.exports = function (Adoptionsuspensionrevision) {

    Adoptionsuspensionrevision.remoteMethod('addupdate', {
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

    Adoptionsuspensionrevision.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        } 
        if (request.adoptionsuspensionrevisionid !== undefined && request.adoptionsuspensionrevisionid !== null) {
            return Adoptionsuspensionrevision.updatesuspensionrevision(request, _securityusersid);
        } else {
            return Adoptionsuspensionrevision.addsuspensionrevision(request, _securityusersid);
        }
    }

    Adoptionsuspensionrevision.addsuspensionrevision = async function (request, _securityusersid) {
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var v_adoptionsuspensionrevisionid;
        var comments;
        if (request.comments !== undefined && request.comments !== null)
            {comments = request.comments;}
        else
            {comments = '';}
        try {
            const data = await Adoptionsuspensionrevision.create({
                adoptionagreementid: request.adoptionagreementid,
                adoptionplanningid: request.adoptionplanningid,
                transactiondate: new Date().toLocaleString(),
                suspensionreasontypekey: request.suspensionreasontypekey,
                suspensionbegindate: request.suspensionbegindate,
                suspensionenddate: request.suspensionenddate,
                suspensionremarks: request.suspensionremarks,
                insertedby: securityusersid,
                updatedby: securityusersid
            });
            v_adoptionsuspensionrevisionid = data.adoptionsuspensionrevisionid;
            var status = 15;
            var nofitymsg = adoptionrevisionstr;
            var routeddescription = adoptionrevisionstr;
            if (request.servicecaseid == null && request.servicecaseid === undefined) {
                request.servicecaseid = '';
            }
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
            await util.executeDBQuery(sql, [v_adoptionsuspensionrevisionid, securityusersid, 'ADSR', status, comments, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1]);
            var responseJson = {};
            responseJson.adoptionsuspensionrevisionid = v_adoptionsuspensionrevisionid;
            return responseJson;
        } catch (err) {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        }
    }

    Adoptionsuspensionrevision.updatesuspensionrevision = async (request, _securityusersid) => {
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var v_adoptionsuspensionrevisionid;
        var comments;
        if (request.comments !== undefined && request.comments !== null)
            {comments = request.comments;}
        else
            {comments = '';}
        try {
            const data = await Adoptionsuspensionrevision.updateAll(
                { adoptionsuspensionrevisionid: request.adoptionsuspensionrevisionid },
                {
                    suspensionreasontypekey: request.suspensionreasontypekey,
                    suspensionbegindate: request.suspensionbegindate,
                    suspensionenddate: request.suspensionenddate,
                    suspensionremarks: request.suspensionremarks,
                    updatedby: securityusersid
                });
            v_adoptionsuspensionrevisionid = data.adoptionsuspensionrevisionid;
            var status = 15;
            var nofitymsg = adoptionrevisionstr;
            var routeddescription = adoptionrevisionstr;
            if (request.servicecaseid == null && request.servicecaseid === undefined) {
                request.servicecaseid = '';
            }
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
            await util.executeDBQuery(sql, [v_adoptionsuspensionrevisionid, securityusersid, 'ADSR', status, comments, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1]);
            return 'UPDATED SUCCESSFULLY';
        } catch (err) {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        }
    }

    Adoptionsuspensionrevision.remoteMethod('getsuspensionhistory', {
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

    Adoptionsuspensionrevision.getsuspensionhistory = async request => {
        var pageno = request.page;
        var pagesize = request.limit;
        var adoptionagreementid = request.where.adoptionagreementid ? request.where.adoptionagreementid : null;
        try {
            const sql = 'select * from getsuspensionhistory($1, $2, $3)';
            return await util.executeDBQuery(sql, [adoptionagreementid,pageno, pagesize]);
        } catch (err) {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        }
    }

    Adoptionsuspensionrevision.remoteMethod('getadoptionsuspension', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});
    Adoptionsuspensionrevision.getadoptionsuspension = async request =>{

        var pageno = request.page;
        var pagesize = request.limit;

        try {
            const sql = 'select * from getadoptionsuspension($1, $2, $3)';
            const data = await util.executeDBQuery(sql, [request.where.adoptioncaseid, pageno, pagesize]);
            return data[0].getadoptionsuspension;
        } catch (err) {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        }
    }

    Adoptionsuspensionrevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionsuspensionrevision.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionsuspensionrevision.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}