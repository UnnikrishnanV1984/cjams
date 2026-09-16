'use strict';
const LOGGER = require("log4js").getLogger("serviceagreement");
const app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(ServiceAgreement) {
	// Geting service agreement
	ServiceAgreement.list= function(request) {
        LOGGER.debug("caseID" + request.where.caseid);
	    if(request.where && request.where.caseid !== undefined) {          

                const sql = 'select * from getserviceagreementlist($1,$2,$3,$4,$5)';
                return util.executeSecondaryNodeDBQuery(sql, [request.page,request.limit, request.where.caseid,request.where.sortdirection, request.where.sortcolumn])
                .then(resp => {
                    return resp;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }	     
        return Promise.resolve([]);
    };

    ServiceAgreement.add = (request,reqctx) => {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        const prs = [];
        
        if (request.agreementid != null || request.agreementid != undefined) {  
            return ServiceAgreement.updateAll(
                { agreementid: request.agreementid },
                {
                    caseid: request.caseid,
                    signatureobtflag: request.signatureobtflag,
                    approvalstatustypekey: request.approvalstatustypekey,
                    agreementdate: request.agreementdate ,
                    approvaldate: request.approvaldate,
                    staffid: request.staffid,
                    associateid: request.associateid,
                    supervisorid: request.supervisorid,
                    attentiontx: request.attentiontx,
                    insertedby: suserid,
                    updatedby: suserid,
                }).then(data1 => {
                    var sql = 'UPDATE serviceagreement set supervisorid = $2 where agreementid = $1';
                    return util.executeDBQuery(sql,[request.agreementid,request.supervisorid])
                    .then(data2 => {
                        return data2;
                    })
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
                }).then(data3 => {
                    var sql = 'UPDATE serviceagreementlist set activeflag = 0 where agreementid = $1';
                    return util.executeDBQuery(sql,[request.agreementid])
                    .then(data4 => {
                        return data4;
                    })
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
                }).then(data5 => {
                    var personarray = request.persons;
                    if (personarray && Array.isArray(personarray)) {
                        personarray.forEach(persons => {
                            prs.push(app.models.ServiceAgreementList.create({
                                agreementid: request.agreementid,
                                personid: persons,
                                associateid: request.associateid,
                                collateralid: request.collateralid,
                                signeddate: request.signeddate,
                                signagreementflag: request.signagreementflag,
                                staffid: request.staffid,
                                supervisorid: request.supervisorid,
                                insertedby: suserid,
                                updatedby: suserid,
                            }).catch(err => LOGGER.error(err)))
                        })
                    }                    
                    ServiceAgreement.ServiceAgreementRouting(request,suserid);
                    return Promise.all(prs);
                });                   
                   
        } else {
            return ServiceAgreement.create({
                caseid: request.caseid,
                signatureobtflag: request.signatureobtflag,
                approvalstatustypekey: request.approvalstatustypekey,
                agreementdate: request.agreementdate ,
                approvaldate: request.approvaldate,
                staffid: request.staffid,
                associateid: request.associateid,
                supervisorid: request.supervisorid,
                attentiontx: request.attentiontx,
                insertedby: suserid,
                updatedby: suserid
            }).then(data => {
                request.agreementid = data.agreementid; 
                var personarray = request.persons;
                if (personarray && Array.isArray(personarray)) {
                    personarray.forEach(persons => {
                        prs.push(app.models.ServiceAgreementList.create({
                            agreementid: data.agreementid,
                            personid: persons,
                            associateid: request.associateid,
                            collateralid: request.collateralid,
                            signeddate: request.signeddate,
                            signagreementflag: request.signagreementflag,
                            staffid: request.staffid,
                            supervisorid: request.supervisorid,
                            insertedby: suserid,
                            updatedby: suserid,
                        }).catch(err => LOGGER.error(err)))
                    })
                }
                ServiceAgreement.ServiceAgreementRouting(request,suserid);
                return Promise.all(prs);
            }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
    };
    
    ServiceAgreement.ServiceAgreementRouting = function (request,suserid) {
		var userid =request && request.securityuserid?request.securityuserid:suserid;
		var status = 15;
		var nofitymsg = 'Service Agreement Submitted for review';
        LOGGER.debug(nofitymsg);
		if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() == "rejected") {
            request.supervisorid = '';
            status = 17;
			nofitymsg = 'Service Agreement Rejected ';
		}
		else if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() == "approved") {
			status = 16;
			nofitymsg = 'Service Agreement Approved ';
            request.supervisorid = '';
        }
        LOGGER.debug(nofitymsg);
		if(request && request.caseid == null && request.caseid == undefined){
			request.caseid = '';
        } 
        if(request && request.servicerequestid == null && request.servicerequestid == undefined){
			request.servicerequestid = '';
		} 
        LOGGER.debug(nofitymsg);
		var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
        LOGGER.debug(sql);
        LOGGER.debug(request.servicerequestid, userid, 'IHSA', status, request.attentiontx, '', false, false, false, nofitymsg,'',request.servicerequestid);
		return util.executeDBQuery(sql, [request.agreementid, userid, 'IHSA', status, request.attentiontx,  request.supervisorid, false, false, false, nofitymsg,'',request.caseid,'',1])
			.then(data => {
                LOGGER.debug('routingintake'+JSON.stringify(data));
                return data;
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	}

    
	// Get service agreement List
    ServiceAgreement.remoteMethod('list', {
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
			type: 'object',
			root: true
		}
    });
    // Adding Service Agreement
    ServiceAgreement.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : '',type : 'object',
            http : {source : 'body'}},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],
        returns: {
            type : 'object',
            root : true
        }
    });

	ServiceAgreement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	ServiceAgreement.observe('access', (ctx, next) => util.access(ctx, next));
	ServiceAgreement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};