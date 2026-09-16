'use strict';
const LOGGER = require("log4js").getLogger("investigationfinding");
const util = require('../utils/utils');
const app = require('../../server/server');
const pdf = require('../models/pdf');
var config = require('../../server/config.json');

module.exports = function(Investigationfinding) {


	Investigationfinding.getfacetofacedetails =(request)=>{
		const iscaseexpunged  = request.where.iscaseexpunged ?? 0; 
		var sql = 'select * from getfacetofacedetails($1,$2,$3,$4)';
		return util.executeDBQuery(sql,[request.where.intakeserviceid,request.where.intakeNumber,request.where.isExpungementSuperUser,iscaseexpunged])
		.then(data =>{
			return data[0].getfacetofacedetails;
		})
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
		}

		Investigationfinding.remoteMethod('getfacetofacedetails', {
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
				type : 'Object',
				root : true
			}
	  })


	  Investigationfinding.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
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
	

	Investigationfinding.addupdate =(request, reqctx)=>{
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 	
		var v_investigationfindingid = null;
		const prs =[];	
		var investigationfindingtypepersons = request.investigationfindingtypeperson;
		var investigationfindingguardians = request.investigationfindingguardian;
  
	   if((request.investigationfindingid === undefined || request.investigationfindingid === null) )
	  {
		  
		  return  Investigationfinding.create({
			personid:request.personid,
			intakeserviceid:request.intakeserviceid,
			invsfindingjurisdiction:request.invsfindingjurisdiction,
			invsfindingaddress:request.invsfindingaddress,
			investigationfindingdate:request.investigationfindingdate,
			socialhistorydesc:request.socialhistorydesc,
			familyhistorydesc:request.familyhistorydesc,
			educationalfactors:request.educationalfactors,
			psychiatricdesc:request.psychiatricdesc,
			psychiatricimportinfo:request.psychiatricimportinfo,
			financialimportinfo:request.financialimportinfo,
			assetdetailsdesc:request.assetdetailsdesc,
			legalinfopoa:request.legalinfopoa,
			legalinforeppayee:request.legalinforeppayee,
			legalinfocourtinvolved:request.legalinfocourtinvolved,
			legalinfodesc:request.legalinfodesc,
			clentcapacitydesc:request.clentcapacitydesc,
			reasonclosingdesc:request.reasonclosingdesc,
			apsworkersigndate:request.apsworkersigndate,
			supervisorsigndate:request.supervisorsigndate,	
			victim_explanation:request.victim_explanation,
			sibling_explanation:request.sibling_explanation,
			guardian_explanation:request.guardian_explanation,
			maltreator_explanation:request.maltreator_explanation,
			med_assessmnts:request.med_assessmnts,
			expert_assessmnts:request.expert_assessmnts,
			collateral_interviews:request.collateral_interviews,
			criminal_history_inv:request.criminal_history_inv,
			home_conditions:request.home_conditions,
			insertedby: _securityusersid,
		    updatedby: _securityusersid,
			 
			  }).then(data=>{
				v_investigationfindingid=data.investigationfindingid;

				if(Array.isArray(investigationfindingtypepersons)){
					investigationfindingtypepersons.forEach(investigationfindingtypeperson =>{
						prs.push(
							app.models.Investigationfindingtypeperson.create({
							investigationfindingid:v_investigationfindingid, 
							intakeservicerequestactorid:investigationfindingtypeperson.intakeservicerequestactorid,   
							invesfindingpersonname:investigationfindingtypeperson.invesfindingpersonname,                 
							invsfindingpersonsupporttype:investigationfindingtypeperson.invsfindingpersonsupporttype, 							 
							invesfindingpersondesc:investigationfindingtypeperson.invesfindingpersondesc, 
							investigationfindingpersontype:investigationfindingtypeperson.investigationfindingpersontype,                  
							insertedby: _securityusersid,
							updatedby: _securityusersid
							})
						)
					});
				}

				if(Array.isArray(investigationfindingguardians)){
					investigationfindingguardians.forEach(investigationfindingguardian =>{
						prs.push(
							app.models.Investigationfindingguardian.create({
							investigationfindingid:v_investigationfindingid,                   
							intakeservicerequestactorid:investigationfindingguardian.intakeservicerequestactorid, 							 							             
							insertedby: _securityusersid,
							updatedby: _securityusersid
							})
						)
					});
				}

				return Promise.all(prs);
				})
			  
			}
			else
			{
				return  Investigationfinding.updateAll(
					{ investigationfindingid:request.investigationfindingid},
					{
						invsfindingjurisdiction:request.invsfindingjurisdiction,
						invsfindingaddress:request.invsfindingaddress,
						investigationfindingdate:request.investigationfindingdate,
						socialhistorydesc:request.socialhistorydesc,
						familyhistorydesc:request.familyhistorydesc,
						educationalfactors:request.educationalfactors,
						psychiatricdesc:request.psychiatricdesc,
						psychiatricimportinfo:request.psychiatricimportinfo,
						financialimportinfo:request.financialimportinfo,
						assetdetailsdesc:request.assetdetailsdesc,
						legalinfopoa:request.legalinfopoa,
						legalinforeppayee:request.legalinforeppayee,
						legalinfocourtinvolved:request.legalinfocourtinvolved,
						legalinfodesc:request.legalinfodesc,
						clentcapacitydesc:request.clentcapacitydesc,
						reasonclosingdesc:request.reasonclosingdesc,
						apsworkersigndate:request.apsworkersigndate,
						supervisorsigndate:request.supervisorsigndate,	
						insertedby: _securityusersid,
						victim_explanation:request.victim_explanation,
						sibling_explanation:request.sibling_explanation,
						guardian_explanation:request.guardian_explanation,
						maltreator_explanation:request.maltreator_explanation,
						med_assessmnts:request.med_assessmnts,
						expert_assessmnts:request.expert_assessmnts,
						collateral_interviews:request.collateral_interviews,
						criminal_history_inv:request.criminal_history_inv,
						home_conditions:request.home_conditions,
						updatedby: _securityusersid
					}
					).then(data =>{

						v_investigationfindingid = request.investigationfindingid;
						var sql = 'select * from updateinvsfindingpersonguardian($1)';
						return util.executeDBQuery(sql,[v_investigationfindingid])
						.then(_data => {
							LOGGER.info(_data);
							return _data
						})
						.catch(err => {
							LOGGER.error(err)
							return err;
						})
			}).then(data =>{
				
				if(Array.isArray(investigationfindingtypepersons)){
					investigationfindingtypepersons.forEach(investigationfindingtypeper =>{
						prs.push(
							app.models.Investigationfindingtypeperson.create({
							investigationfindingid:v_investigationfindingid, 
							intakeservicerequestactorid:investigationfindingtypeper.intakeservicerequestactorid,   
							invesfindingpersonname:investigationfindingtypeper.invesfindingpersonname,                 
							invsfindingpersonsupporttype:investigationfindingtypeper.invsfindingpersonsupporttype, 							 
							invesfindingpersondesc:investigationfindingtypeper.invesfindingpersondesc,   
							investigationfindingpersontype:investigationfindingtypeper.investigationfindingpersontype,                
							insertedby: _securityusersid,
							updatedby: _securityusersid
							})
						)
					});
				}

				if(Array.isArray(investigationfindingguardians)){
					investigationfindingguardians.forEach(investigationfindingguard =>{
						prs.push(
							app.models.Investigationfindingguardian.create({
							investigationfindingid:v_investigationfindingid,                   
							intakeservicerequestactorid:investigationfindingguard.intakeservicerequestactorid, 							 							             
							insertedby: _securityusersid,
							updatedby: _securityusersid
							})
						)
					});
				}

				return Promise.all(prs);
				})
			  
			
		}
	  }


	  Investigationfinding.remoteMethod('list', {
        http: {
              path: '/list',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
	  });
	  

	  Investigationfinding.list = async request => {
        const v_intakeserviceid  = request.where.intakeserviceid;
		var sql = 'SELECT * FROM getinvestigationfindinglist($1)';
		try {
			return await util.executeDBQuery(sql, [v_intakeserviceid]);
		} catch (err) {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		}
      };

	  Investigationfinding.remoteMethod('getCisData', {
        http: {
              path: '/getCisData',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
	  });
	  

	  Investigationfinding.getCisData = async request => {
        const v_referralid  = request.where.referralid;
		var sql = 'SELECT * FROM tb_conv_inv_finding where referral_id=$1';
		try {
			return await util.executeDBQuery(sql, [v_referralid]);
		} catch (err) {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		}
      };

	
	  Investigationfinding.downloadInvestigationSummaryReport = (request,res) =>{
        return Promise.resolve(pdf.downloadInvestigationSummaryReport(request, request.where.investigationsummaryreport));
    }

    Investigationfinding.remoteMethod('downloadInvestigationSummaryReport', {
        http: {
            path: '/downloadInvestigationSummaryReport',
            verb: 'post'
        },
        accepts: [{
                arg: 'data',
                type: 'Object',
                http: {
                    source: 'body'
                }
            },
            {
                arg: 'res',
                type: 'object',
                'http': {
                    source: 'res'
                }
            }

        ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
    })
	
	Investigationfinding.observe('after save', (ctx, next) => {
		/* call publish function to handle expungement */
		var sql = 'SELECT * FROM publishinvestigationfinding($1,$2,$3)';
		return util.executeDBQuery(sql, [null, null, ctx.instance.investigationallegationid])
			.then(() => { /* DO NOTHING on success */ })
			.catch(() => { /* DO NOTHING on error - fire and forget */ });
	});

    Investigationfinding.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Investigationfinding.observe('access', (ctx, next) => util.access(ctx, next));
	Investigationfinding.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
 

};
