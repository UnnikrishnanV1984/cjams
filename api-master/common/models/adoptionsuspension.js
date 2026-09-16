'use strict';
const LOGGER = require("log4js").getLogger("adoptionsuspension");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const adoptionsuspensionstr = 'Adoption Suspension Submitted for review';
module.exports = function (Adoptionsuspension) {

    Adoptionsuspension.remoteMethod('addupdate', {
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

    Adoptionsuspension.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        return Adoptionsuspension.addsuspension(request, _securityusersid);
    }

    Adoptionsuspension.addsuspension = function (request, _securityusersid) {
        var securityusersid = (request.securityuserid ? request.securityuserid : _securityusersid);
        var v_adoptionsuspensionid;
        var revisionObj = {};
        if (request.servicecaseid == null && request.servicecaseid === undefined) {
            request.servicecaseid = '';
        }
        var presuspensionupdate = Promise.resolve();
        if (request.adoptionsuspensionid !== undefined && request.adoptionsuspensionid !== null) {
            var sql1 = 'UPDATE adoptionsuspension SET activeflag=0, updatedon=now(), updatedby=\''+securityusersid+'\'  WHERE adoptionagreementid =\''+request.adoptionagreementid+'\'' ;
            var sql2 = 'UPDATE adoptionsuspensionrevision SET activeflag=0, updatedon=now(), updatedby=\''+securityusersid+'\' WHERE adoptionagreementid =\''+request.adoptionagreementid+'\'' ;
            presuspensionupdate = util.executeDBQuery(sql1, [])
                .then(() => util.executeDBQuery(sql2, []))
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
        return presuspensionupdate.then(() => Adoptionsuspension.create({
            adoptionagreementid: request.adoptionagreementid,
            adoptionplanningid: request.adoptionplanningid,
            transactiondate: new Date().toLocaleString(),
            suspensionreasontypekey: request.suspensionreasontypekey,
            suspensionbegindate: request.suspensionbegindate,
            suspensionenddate: request.suspensionenddate,
            suspensionremarks: request.suspensionremarks,
            insertedby: securityusersid,
            updatedby: securityusersid,
            insertedon: new Date().toLocaleString(),
            updatedon: new Date().toLocaleString()
        }).then(data => {


            revisionObj.adoptionagreementid= data.adoptionagreementid;
            revisionObj.adoptionplanningid= data.adoptionplanningid;
            revisionObj.transactiondate= new Date().toLocaleString();
            revisionObj.uspensionreasontypekey= data.suspensionreasontypekey;
            revisionObj.suspensionbegindate= data.suspensionbegindate;
            revisionObj.suspensionenddate= data.suspensionenddate;
            revisionObj.suspensionremarks= data.suspensionremarks;
            revisionObj.insertedby= securityusersid;
            revisionObj.activeflag=request.activeflag;
            revisionObj.insertedby= securityusersid;
            revisionObj.approvalstatustypekey='3045';
            revisionObj.adoptionsuspensionid=data.adoptionsuspensionid;
            app.models.Adoptionsuspensionrevision.create(revisionObj).then(
              resp=>{
                v_adoptionsuspensionid = data.adoptionsuspensionid;
                var status = 15;
                var nofitymsg = adoptionsuspensionstr;
                var routeddescription = adoptionsuspensionstr;

                var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';

                return util.executeDBQuery(sql, [v_adoptionsuspensionid, securityusersid, 'ADSR', status, nofitymsg, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1])
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
               }
              );
              return data;
            })).catch(err => util.logError(err));
        }

    Adoptionsuspension.updatesuspension = (request, _securityusersid) => {
        var securityusersid = (request.securityuserid?request.securityuserid: _securityusersid);
        var v_adoptionsuspensionid;
        var comments = '';
        if (request.comments !== undefined && request.comments !== null)
            {comments = request.comments;}
       /*  else
            {comments = '';} */
        if (request.servicecaseid == null && request.servicecaseid === undefined) {  //SonarQube complexity fix - moved it to top outside of function
            request.servicecaseid = '';
        }
        return Adoptionsuspension.updateAll(
            { adoptionsuspensionid: request.adoptionsuspensionid },
            {
                suspensionreasontypekey: request.suspensionreasontypekey,
                suspensionbegindate: request.suspensionbegindate,
                suspensionenddate: request.suspensionenddate,
                suspensionremarks: request.suspensionremarks,
                updatedby: securityusersid,
                updatedon: new Date().toLocaleString()
            }).then(data => {
            
            revisionObj.adoptionagreementid= data.adoptionagreementid;
            revisionObj.adoptionplanningid= data.adoptionplanningid;
            revisionObj.transactiondate= new Date().toLocaleString();
            revisionObj.uspensionreasontypekey= data.suspensionreasontypekey;
            revisionObj.suspensionbegindate= data.suspensionbegindate;
            revisionObj.suspensionenddate= data.suspensionenddate;
            revisionObj.suspensionremarks= data.suspensionremarks;
            revisionObj.insertedby= securityusersid;
            revisionObj.activeflag=request.activeflag;
            revisionObj.insertedby=securityusersid;
            revisionObj.adoptionsuspensionid=data.adoptionsuspensionid;
            revisionObj.approvalstatustypekey='3045';
            app.models.Adoptionsuspensionrevision.create(revisionObj).then(
              resp=>{


                v_adoptionsuspensionid = data.adoptionsuspensionid;
                var status = 15;
                var nofitymsg = adoptionsuspensionstr;
                var routeddescription = adoptionsuspensionstr;
                var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
                return util.executeDBQuery(sql, [v_adoptionsuspensionid, securityusersid, 'ADSR', status, comments, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1])
                    .then(data1 => data1[0].routingintake)
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
              });
            }).then(resps => 'UPDATED SUCCESSFULLY').catch(err => util.logError(err)); 
    }

    Adoptionsuspension.remoteMethod('getsuspensionhistory', {
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

    Adoptionsuspension.getsuspensionhistory = request => {
        var pageno = request.page;
        var pagesize = request.limit;
        var adoptionagreementid = request.where.adoptionagreementid ? request.where.adoptionagreementid : null;
        const sql = 'select * from getsuspensionhistory($1, $2, $3)';
        return util.executeDBQuery(sql, [adoptionagreementid,pageno, pagesize])
            .then(resp => resp)
            .catch(err => err);
    }

    Adoptionsuspension.remoteMethod('getadoptionsuspension', {
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
    Adoptionsuspension.getadoptionsuspension = request =>{

        var pageno = request.page;
        var pagesize = request.limit;

        const sql = 'select * from getadoptionsuspension($1, $2, $3)';
        return util.executeDBQuery(sql, [request.where.adoptioncaseid, pageno, pagesize])
           .then(data => data[0].getadoptionsuspension)
           .catch(err => err);
    }

    Adoptionsuspension.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionsuspension.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionsuspension.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
