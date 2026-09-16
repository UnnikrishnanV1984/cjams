'use strict';
const LOGGER = require("log4js").getLogger("gapagreement");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const { Logger } = require("log4js");
const gapmsg = 'Guardianship Agreement Rate Submitted for review';
const routingintakesql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
const dummyid = '00000000-0000-0000-0000-000000000000';
const gapsubmitmsg = 'Guardianship Agreement Submitted for review';
module.exports = function(Gapagreement) {

    /**Gapagreement add */
    Gapagreement.remoteMethod('add', {
        http: {
            path: '/add',
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

    Gapagreement.add = async function(request, reqctx)
    {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        var securityusersid = _securityusersid;
        var nowDate = new Date();
        var gapagreementid;
        var gapagreementrateid;
				if(request.servicecaseid == null && request.servicecaseid === undefined){
					request.servicecaseid = '';
				} 
        if(request.gapagreementid == null || request.gapagreementid === undefined){
        return Gapagreement.create({
            gapid:request.gapid,
            iscomprehensivehomestudy:request.iscomprehensivehomestudy,
            iscgawardedcustody:request.iscgawardedcustody,
            isplacementenddate:request.isplacementenddate,
            ischildreceivetca:request.ischildreceivetca,
            tcaamount:request.tcaamount,
            startdate:request.startdate,
            enddate:request.enddate,
            signaturedate:request.signaturedate,
            guardianonedate:request.guardianonedate,
            guardiantwodate:request.guardiantwodate,
            ldssdate:request.ldssdate,
            guardian1signature: request.guardian1signature,
            guardian2signature: request.guardian2signature,
            ldssdirectorsignature: request.ldssdirectorsignature,
            isfianotified : request.isfianotified,
            signaturecheck: request.signaturecheck,
            fianotifieddate : request.fianotifieddate,
            isrcnotifiedcontact : request.isrcnotifiedcontact,
            iscsnotifiedtocustody : request.iscsnotifiedtocustody,
            insertedby:securityusersid,
            updatedby:securityusersid,
            updatedon: nowDate,
            insertedon: nowDate,
            agreementtyperefid: request.agreementtyperefid
        }).then(async data=>{
            gapagreementid = data.gapagreementid;
            const gapagreementrevisionObj={};
            gapagreementrevisionObj.gapid=data.gapid;
            gapagreementrevisionObj.gapagreementid=data.gapagreementid;
            gapagreementrevisionObj.iscomprehensivehomestudy=data.iscomprehensivehomestudy;
            gapagreementrevisionObj.isplacementenddate=data.isplacementenddate;
            gapagreementrevisionObj.ischildreceivetca=data.ischildreceivetca;
            gapagreementrevisionObj.tcaamount=data.tcaamount;
            gapagreementrevisionObj.startdate=data.startdate;
            gapagreementrevisionObj.enddate=data.enddate;
            gapagreementrevisionObj.signaturedate=data.signaturedate;
            gapagreementrevisionObj.guardianonedate=data.guardianonedate;
            gapagreementrevisionObj.guardiantwodate=data.guardiantwodate;
            gapagreementrevisionObj.ldssdate= data.ldssdate;
            gapagreementrevisionObj.guardian1signature= data.guardian1signature; 
            gapagreementrevisionObj.guardian2signature= data.guardian2signature; 
            gapagreementrevisionObj.ldssdirectorsignature= data.ldssdirectorsignature;  
            gapagreementrevisionObj.isfianotified = data.isfianotified;
            gapagreementrevisionObj.fianotifieddate = data.fianotifieddate;
            gapagreementrevisionObj.signaturecheck = data.signaturecheck;
            gapagreementrevisionObj.isrcnotifiedcontact = data.isrcnotifiedcontact;
            gapagreementrevisionObj.iscsnotifiedtocustody = data.iscsnotifiedtocustody;
            gapagreementrevisionObj.approvalstatustypekey= '3045'; 
            gapagreementrevisionObj.insertedby = securityusersid;
            gapagreementrevisionObj.updatedby = securityusersid;
            gapagreementrevisionObj.updatedon = nowDate;
            gapagreementrevisionObj.insertedon = nowDate;
            gapagreementrevisionObj.agreementtyperefid = data.agreementtyperefid;
            await app.models.Gapagreementrevision.create(gapagreementrevisionObj);

      /*      prs.push( app.models.Gapagreementrate.create({
                gapagreementid:gapagreementid,
                providerid:request.gapagreementrate.providerid,
                startdate:request.gapagreementrate.ratestartdate,
                enddate:request.gapagreementrate.rateenddate,
                paymentamout:request.gapagreementrate.paymentamout,
                isoverride:request.gapagreementrate.isoverride,
                paymenttypekey:request.gapagreementrate.paymenttypekey,
                notes:request.gapagreementrate.notes,
                insertedby:securityusersid
            }).catch(err => LOGGER.error(err))*?
          ) */
          const status = 15;
          
          const gapagreementrate = request.gapagreementrate;
          const response = [];
          if (Array.isArray(gapagreementrate)) {
            gapagreementrate.forEach(element => {
                element.activeflag = 1;
                element.insertedby=securityusersid;
                element.gapagreementid=gapagreementid;
                var revisionObj={};
                
                response.push(
                  
                    app.models.Gapagreementrate.create(element).then(async _data =>
                        {
                          gapagreementrateid=_data.gapagreementrateid;
                          revisionObj.gaprateid=_data.gapagreementrateid;
                          revisionObj.guardiansubsidyid=request.gapid;
                          revisionObj.transactiondate=element.transactiondate;
                          revisionObj.ratestartdate=element.startdate;
                          revisionObj.rateenddate=element.enddate;
                          revisionObj.paymentamt=element.paymentamout;
                          revisionObj.notes=element.comments;
                          revisionObj.activeflag=element.activeflag;
                          revisionObj.insertedby=element.insertedby;
                          revisionObj.providerid=element.providerid;
                          revisionObj.approvalstatustypekey= '3045'; 
                          app.models.Gapratesrevision.create(revisionObj);
                          const nofitymsg1 = gapmsg;
                          const routeddescription1 = gapmsg;
                          const comments1 = gapmsg;
                          var sql1 = routingintakesql;
                          await util.executeDBQuery(sql1, [gapagreementrateid,securityusersid,'GARR',status,comments1,'',false,false,false,
                          nofitymsg1,routeddescription1,request.servicecaseid,'',1])
                            .then(result => {
                                LOGGER.info(result);
                            })
                            .catch(err => {
                                LOGGER.error('>>>>ERROR:', err);
                                throw err;
                            })
                           addDocumentproperties(request, gapagreementid, _securityusersid);
                        })
                    )
            })
        }


            var nofitymsg = gapsubmitmsg;
            var routeddescription = gapsubmitmsg;
            var comments = gapsubmitmsg;
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15)';
						await util.executeDBQuery(sql, [gapagreementid,securityusersid,'GAAR',status,comments,'',false,false,false,
						nofitymsg,routeddescription,request.servicecaseid,'',1,request.userrole])
						.then(result => {
								LOGGER.info(result);
						})
						.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
						})

            Promise.all(response);
             return data;
        }).catch(err => util.logError(err));
    }
    else
    {
        let prs = [];
        gapagreementid = request.gapagreementid;
        const gapagreementrate = request.gapagreementrate;
        const response = [];

          if(request.isagreementedit==="yes"){

            var newaggreementenddate= request.enddate;  
            var aggreementapprovalstatustypekey='3045';
            var sqlgapagreement = 'UPDATE gapagreementrevision SET activeflag=0, updatedon = now(), updatedby = $1 WHERE approvalstatustypekey =$2 and gapagreementid =$3';
						await util.executeDBQuery(sqlgapagreement,[securityusersid , aggreementapprovalstatustypekey,gapagreementid])
						.then(_data => {
								LOGGER.info(_data);
								return _data;
						})
						.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
						})
             app.models.Gapagreement.updateAll({gapagreementid:request.gapagreementid},
                {
                    iscomprehensivehomestudy:request.iscomprehensivehomestudy,
                    iscgawardedcustody:request.iscgawardedcustody,
                    isplacementenddate:request.isplacementenddate,
                    ischildreceivetca:request.ischildreceivetca,
                    tcaamount:request.tcaamount,
                    startdate:request.startdate,
                    enddate:request.enddate,
                    signaturedate:request.signaturedate,
                    guardianonedate:request.guardianonedate,
                    guardiantwodate:request.guardiantwodate,
                    ldssdate:request.ldssdate,
                    guardian1signature: request.guardian1signature,
                    guardian2signature: request.guardian2signature,
                    ldssdirectorsignature: request.ldssdirectorsignature,
                    isfianotified : request.isfianotified,
                    signaturecheck: request.signaturecheck,
                    fianotifieddate : request.fianotifieddate,
                    isrcnotifiedcontact : request.isrcnotifiedcontact,
                    iscsnotifiedtocustody : request.iscsnotifiedtocustody,
                    updatedby:securityusersid,
                    updatedon: nowDate,
                    agreementtyperefid: request.agreementtyperefid

                }
               ); 
                var status1 = 15;
                const gapagreementrevisionObj={};
                gapagreementrevisionObj.gapid=request.gapid;
                gapagreementrevisionObj.gapagreementid=request.gapagreementid;
                gapagreementrevisionObj.iscomprehensivehomestudy=request.iscomprehensivehomestudy;
                gapagreementrevisionObj.isplacementenddate=request.isplacementenddate;
                gapagreementrevisionObj.ischildreceivetca=request.ischildreceivetca;
                gapagreementrevisionObj.tcaamount=request.tcaamount;
                gapagreementrevisionObj.startdate=request.startdate;
                gapagreementrevisionObj.enddate=newaggreementenddate;
                gapagreementrevisionObj.signaturedate=request.signaturedate;
                gapagreementrevisionObj.guardianonedate=request.guardianonedate;
                gapagreementrevisionObj.guardiantwodate=request.guardiantwodate;
                gapagreementrevisionObj.ldssdate= request.ldssdate; 
                gapagreementrevisionObj.guardian1signature= request.guardian1signature; 
                gapagreementrevisionObj.guardian2signature= request.guardian2signature; 
                gapagreementrevisionObj.signaturecheck = request.signaturecheck;
                gapagreementrevisionObj.ldssdirectorsignature= request.ldssdirectorsignature; 
                gapagreementrevisionObj.isfianotified = request.isfianotified;
                gapagreementrevisionObj.fianotifieddate = request.fianotifieddate;
                gapagreementrevisionObj.isrcnotifiedcontact = request.isrcnotifiedcontact;
                gapagreementrevisionObj.iscsnotifiedtocustody = request.iscsnotifiedtocustody;
                gapagreementrevisionObj.approvalstatustypekey= '3045'; 
                gapagreementrevisionObj.updatedon = nowDate;
                gapagreementrevisionObj.updatedby = securityusersid;
                gapagreementrevisionObj.agreementtyperefid= request.agreementtyperefid; 
                
                app.models.Gapagreementrevision.create(gapagreementrevisionObj);

                const nofitymsg1 = gapsubmitmsg;
            const routeddescription1 = gapsubmitmsg;
            const comments1 = gapsubmitmsg;
            
            var sql11 = routingintakesql;
						await util.executeDBQuery(sql11, [request.gapagreementid,securityusersid,'GAAR',status1,comments1,'',false,false,false,
						nofitymsg1,routeddescription1,request.servicecaseid,'',1])
						.then(result => {
								LOGGER.info(result);
						})
						.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
						})
						addDocumentproperties(request, gapagreementid, _securityusersid);
        }

        prs = checkUpdateAggreementRate(request, gapagreementrate, securityusersid, gapagreementid, prs);

            Promise.all(response).then(function (values) {
               values.map(x => {
                    prs.push(x);
                });
            });
       
          return Promise.all(prs)
          .then(_data => "success")
          .catch(err =>err); 
        
    }
}

	function checkUpdateAggreementRate(request, gapagreementrates, securityusersid, gapagreementid, prs) {
		var gapagreementrateid = '';
		if (request.isagreementedit === "no" || request.isagreementedit == null || request.isagreementedit === undefined) {
			if (Array.isArray(gapagreementrates)) {
				//  gapagreementrates.forEach(element => {
				var revisionObj = {};
				gapagreementrates.activeflag = 1;
				gapagreementrates.insertedby = securityusersid;
				gapagreementrates.gapagreementid = gapagreementid;


				request.gapagreementrate.map(gapagreementrate => {
					if (gapagreementrate.gapagreementrateid != null || gapagreementrate.gapagreementrateid !== undefined) {
						gapagreementrateid = gapagreementrate.gapagreementrateid;
						LOGGER.debug(gapagreementrateid + "gapagreementrateid")

						if (gapagreementrate.status === "Review") {
							var approvalstatustypekey = '3045';
							var sqlgap = 'UPDATE gapratesrevision SET activeflag=0 WHERE approvalstatustypekey =$1 and gaprateid =$2';
							util.executeDBQuery(sqlgap,[approvalstatustypekey,gapagreementrateid])
								.then(data => {
									LOGGER.info(data);
								})
								.catch(err => {
									LOGGER.error(err);
									throw err;
								})

							var newenddate = gapagreementrate.enddate;

							revisionObj.gaprateid = gapagreementrate.gapagreementrateid;
							revisionObj.guardiansubsidyid = request.gapid;
							revisionObj.transactiondate = gapagreementrate.transactiondate;
							revisionObj.ratestartdate = gapagreementrate.ratestartdate;
							revisionObj.rateenddate = newenddate;
							revisionObj.paymentamt = gapagreementrate.paymentamout;
							revisionObj.notes = gapagreementrate.comments;
							revisionObj.activeflag = gapagreementrate.activeflag;
							revisionObj.insertedby = gapagreementrate.insertedby;
							revisionObj.providerid = gapagreementrate.providerid;
							revisionObj.approvalstatustypekey = '3045';
							app.models.Gapratesrevision.create(revisionObj);


							const status = 15;
							const nofitymsg = gapmsg;
							const routeddescription = 'Guardianship Agreement Rate  Submitted for review';
							const comments = 'Guardianship Agreement  Rate Submitted for review';
							const sql = routingintakesql;
							util.executeDBQuery(sql,[gapagreementrateid,securityusersid,'GARR',status,comments,'',false,false,false,
								nofitymsg,routeddescription,request.servicecaseid,'',1])
								.then(result => {
									LOGGER.info(result);
								})
								.catch(err => {
									LOGGER.error(err);
									throw err;
								});
							addDocumentproperties(request,gapagreementid,securityusersid);
						}
					}
					else {
                        gapagreementrate.gapagreementid = request.gapagreementid;
						prs.push(
							app.models.Gapagreementrate.create(gapagreementrate)
								.then(data => {
									gapagreementrateid = data.gapagreementrateid;
									revisionObj.gaprateid = data.gapagreementrateid;
									revisionObj.guardiansubsidyid = request.gapid;
									revisionObj.transactiondate = gapagreementrate.transactiondate;
									revisionObj.ratestartdate = gapagreementrate.ratestartdate;
									revisionObj.rateenddate = gapagreementrate.enddate;
									revisionObj.paymentamt = gapagreementrate.paymentamout;
									revisionObj.notes = gapagreementrate.comments;
									revisionObj.activeflag = gapagreementrate.activeflag;
									revisionObj.insertedby = gapagreementrate.insertedby;
									revisionObj.providerid = gapagreementrate.providerid;
									revisionObj.approvalstatustypekey = '3045';
									app.models.Gapratesrevision.create(revisionObj);

									const status = 15;
									const nofitymsg = gapmsg;
									const routeddescription = 'Guardianship Agreement Rate  Submitted for review';
									const comments = 'Guardianship Agreement  Rate Submitted for review';
									util.executeDBQuery(routingintakesql,[gapagreementrateid,securityusersid,'GARR',status,comments,'',false,false,false,
										nofitymsg,routeddescription,request.servicecaseid,'',1])
										.then(result => {
											LOGGER.info(result);
										})
										.catch(err => {
											LOGGER.error(err);
											throw err;
										})
									addDocumentproperties(request,gapagreementid,securityusersid);
								}
								)
						)
					}

				});
			}
		}
		return prs;
	}

	function addDocumentproperties(request, gapagreementid, _securityusersid) {
		if (request.attachment != null && request.attachment !== undefined && request.attachment !== "") {
			//      request.attachment.map(attach => {
			if (Array.isArray(request.attachment)) {
				request.attachment.forEach(attach => {
					attach.objectid = gapagreementid;
					attach.servicecaseid = request.servicecaseid;
					attach.objecttypekey = 'gapagreement';
					attach.insertedby = _securityusersid;
					attach.updatedby = _securityusersid;

					app.models.Documentproperties.create({
						objecttypekey: attach.objecttypekey,
						servicerequestid: attach.servicerequestid,
						servicecaseid: attach.servicecaseid,
						objectid: attach.objectid ? attach.objectid : dummyid,
						documenttypekey: 'Attachment',
						intakenumber: attach.intakenumber,
						documentdate: attach.documentdate,
						thirdpartysourceid: attach.thirdpartysourceid,
						filename: attach.filename,
						originalfilename: attach.originalfilename,
						title: attach.title,
						description: attach.description,
						mime: attach.mime,
						meta: attach.meta,
						encoding: attach.encoding,
						numberofbytes: attach.numberofbytes,
						insertedby: attach.insertedby,
						updatedby: attach.updatedby,
						expirationdate: nowDate.toJSON(),
						rootobjectid: attach.objectid ? attach.objectid : dummyid,
						rootobjecttypekey: attach.objecttypekey,
						s3bucketpathname: attach.s3bucketpathname,
						ecmsdocumentid: attach.ecmsdocumentid
					});
				});
			}
		}
	}

    Gapagreement.remoteMethod('addAttachment', {
        http: {
            path: '/addAttachment',
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

    Gapagreement.addAttachment = function(request, reqctx) {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        const securityuserid = (request.securityuserid ? request.securityuserid : _securityusersid);
        if (request.attachment != null && request.attachment !== undefined && request.attachment !== "") {
            if (Array.isArray(request.attachment)) {
                request.attachment.map(attach => {
                    attach.documentattachment = {};
                    attach.objectid = request.gapagreementid;
                    attach.servicecaseid = request.servicecaseid;
                    attach.objecttypekey = 'gapagreement';
                    attach.insertedby = securityuserid;
                    attach.updatedby = securityuserid;
                    attach.servicerequestid = request.intakeserviceid;          //SonarQube fix - removed the self-assignments
                    attach.documentattachment.attachmentclassificationtypekey = attach.attachmentclassificationtypekey;
                    attach.documentattachment.attachmentclassificationsubtypekey = attach.attachmentclassificationsubtypekey;
                    attach.documentattachment.attachmentdate = attach.documentdate;
                    attach.documentattachment.attachmenttypekey = attach.attachmenttypekey;
                });
            }

            return app.models.Documentproperties.addcommonattachment(request.attachment, null, reqctx).then((res)=>{
                return { code: 200, message: 'success', data: res}
            }).catch(err=>{
                LOGGER.error(err);
            })
        }
        return Promise.resolve({ code: 400, message: 'Invalid request' });
    }


    Gapagreement.remoteMethod('updatechecklist', {
        http: {
                path: '/updatechecklist',
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
    
    Gapagreement.updatechecklist = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var nowDate = new Date();
        // Called from Closing Checklist screen
        if (request.isFinalization) {
            return Gapagreement.updateAll(
                { gapagreementid: request.gapagreementid }, 
                {   ischildreceivetca: request.ischildreceivetca,
                    tcaamount: request.tcaamount,
                    signaturecheck: request.signaturecheck,
                    isfianotified: request.isfianotified,
                    fianotifieddate: request.fianotifieddate,
                    isrcnotifiedcontact: request.isrcnotifiedcontact,
                    iscsnotifiedtocustody: request.iscsnotifiedtocustody,
                    updatedby: securityusersid,
                    updatedon: nowDate,
                    startdate : request.startdate 
                })
            .catch(err => util.logError(err));
        } else { // Called from Rate screen
            return Gapagreement.updateAll(
                { gapagreementid: request.gapagreementid }, 
                {   iscomprehensivehomestudy: request.iscomprehensivehomestudy,
                    iscgawardedcustody: request.iscgawardedcustody,
                    isplacementenddate: request.isplacementenddate,
                    islaendate: request.islaendate,
                    isservicelogsendate: request.isservicelogsendate,
                    updatedby: securityusersid,
                    updatedon: nowDate,
                    startdate : request.startdate
                })
            .catch(err => util.logError(err));
        }
        
    }

    Gapagreement.remoteMethod('checkForActiveSubsidy', {
        http: {
            path: '/checkForActiveSubsidy',
            verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Gapagreement.checkForActiveSubsidy = function (request) {
            var check = "SELECT count(*)" +
                " FROM cjams.tb_GUARDIAN_SUBSIDY A" +
                " WHERE A.CLIENT_ID = $1" +
                " AND A.DELETE_SW = 'N'" +
                " AND A.SUSBSIDY_APPROVAL_STATUS_CD = '3047'" +
                " AND A.SUBSIDY_END_DT > current_date" +
                " AND A.PROVIDER_ID IS NOT null";
            return util.executeSecondaryNodeDBQuery(check, [request.cjamspid])
                .then(res => {
                    var count = JSON.parse(JSON.stringify(res));
                    return count[0].count;
                })
               .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }

	Gapagreement.remoteMethod('list', {
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
     Gapagreement.list = request =>{

        var pageno = request.page;
        var pagesize = request.limit;
        var gapid = request.where.gapid?request.where.gapid:null;
        var objectid = request.where.objectid?request.where.objectid:null;
        var objecttype = request.where.objecttype?request.where.objecttype:'';

        const sql = 'select * from getgapagreementlist($1, $2, $3, $4, $5)';
        return util.executeSecondaryNodeDBQuery(sql, [gapid, pageno, pagesize, objectid,objecttype]).then(data => {
              return data[0].getgapagreementlist;
            }).then(resp => resp)
           .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }

    Gapagreement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Gapagreement.observe('access', (ctx, next) => util.access(ctx, next));
    Gapagreement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
