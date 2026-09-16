'use strict';
const LOGGER = require("log4js").getLogger("ihasprovidermonthlyreport");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Ihasprovidermonthlyreport) {

    Ihasprovidermonthlyreport.remoteMethod('addupdate', {
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
   
    Ihasprovidermonthlyreport.addupdate = function(request, reqctx)
    { 
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;  
        const prs =[];
        var v_ihasprovidermonthlyreportid = null;
        var monthlyreportdays = request.monthlyreportdays;

        if(request.ihasprovidermonthlyreportid=== null || request.ihasprovidermonthlyreportid === undefined)
        {
            return Ihasprovidermonthlyreport.create(request)
            .then(data=>{
				v_ihasprovidermonthlyreportid=data.ihasprovidermonthlyreportid;

				if(Array.isArray(monthlyreportdays)){
					monthlyreportdays.forEach(monthlyreptday =>{
						prs.push(
							app.models.Ihasprovidedmonthlyreportdaysconfig.create({
                            ihasprovidermonthlyreportid:v_ihasprovidermonthlyreportid, 
							activitykey:monthlyreptday.activitykey,   
                            day01:monthlyreptday.day01,
                            day02:monthlyreptday.day02, 
                            day03:monthlyreptday.day03, 
                            day04:monthlyreptday.day04, 
                            day05:monthlyreptday.day05,                  
                            day06:monthlyreptday.day06, 
                            day07:monthlyreptday.day07, 
                            day08:monthlyreptday.day08, 
                            day09:monthlyreptday.day09, 
                            day10:monthlyreptday.day10, 
                            day11:monthlyreptday.day11, 
                            day12:monthlyreptday.day12, 
                            day13:monthlyreptday.day13, 
                            day14:monthlyreptday.day14, 
                            day15:monthlyreptday.day15, 
                            day16:monthlyreptday.day16, 
                            day17:monthlyreptday.day17, 
                            day18:monthlyreptday.day18, 
                            day19:monthlyreptday.day19, 
                            day20:monthlyreptday.day20, 
                            day21:monthlyreptday.day21, 
                            day22:monthlyreptday.day22, 
                            day23:monthlyreptday.day23, 
                            day24:monthlyreptday.day24, 
                            day25:monthlyreptday.day25, 
                            day26:monthlyreptday.day26, 
                            day27:monthlyreptday.day27, 
                            day28:monthlyreptday.day28, 
                            day29:monthlyreptday.day29, 
                            day30:monthlyreptday.day30, 
                            day31:monthlyreptday.day31, 
                            total:monthlyreptday.total, 
                            version:monthlyreptday.version, 	
                                             
							insertedby:_securityusersid,
							updatedby:_securityusersid
							})
						)
					});
                }
                return Promise.all(prs);
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            })
        }
        else
        {
            return  Ihasprovidermonthlyreport.updateAll(
                { ihasprovidermonthlyreportid:request.ihasprovidermonthlyreportid},
                {
                    providername:request.providername,
                    provideraddress:request.provideraddress,
                    providercity:request.providercity,
                    providerstate:request.providerstate,
                    providerphoneno:request.providerphoneno,
                    providerzipcode:request.providerzipcode,
                    categoryihasfamily:request.categoryihasfamily,
                    categoryihasadults:request.categoryihasadults,
                    categoryeligible:request.categoryeligible,
                    categoryihasanothereservice:request.categoryihasanothereservice,
                    providerihasfamily:request.providerihasfamily,
                    providerihasadults:request.providerihasadults,
                    providereligible:request.providereligible,
                    providerihasanothereservice:request.providerihasanothereservice,
                    pca:request.pca,
                    agencyobject:request.agencyobject,
                    aidesignature:request.aidesignature,
                    caregiversignature:request.caregiversignature,	
                    caregiversigndate:request.caregiversigndate,
                    ldsssignature:request.ldsssignature,
                    insertedby:_securityusersid,
                    updatedby:_securityusersid,
                    totalinvoiceamount:request.totalinvoiceamount,
                    reportstatus:request.reportstatus,
                    ldsssignaturedate:request.ldsssignaturedate,
                    aidesignaturedate:request.aidesignaturedate,
                    accountclerksign:request.accountclerksign,
                    providerssn:request.providerssn,
                    reportedmonthyear:request.reportedmonthyear
                }
                ).then(_data =>{

                    v_ihasprovidermonthlyreportid = request.ihasprovidermonthlyreportid;
                    var sql = 'select * from updateihasprovidedmonthlyreport($1)';
                    return util.executeDBQuery(sql,[v_ihasprovidermonthlyreportid]);
        }).then(_data =>{
            
            if(Array.isArray(monthlyreportdays)){
                monthlyreportdays.forEach(monthlyreportday =>{
                    prs.push(
                        app.models.Ihasprovidedmonthlyreportdaysconfig.create({
                        ihasprovidermonthlyreportid:v_ihasprovidermonthlyreportid, 
                        activitykey:monthlyreportday.activitykey,   
                        day01:monthlyreportday.day01,
                        day02:monthlyreportday.day02, 
                        day03:monthlyreportday.day03, 
                        day04:monthlyreportday.day04, 
                        day05:monthlyreportday.day05,                  
                        day06:monthlyreportday.day06, 
                        day07:monthlyreportday.day07, 
                        day08:monthlyreportday.day08, 
                        day09:monthlyreportday.day09, 
                        day10:monthlyreportday.day10, 
                        day11:monthlyreportday.day11, 
                        day12:monthlyreportday.day12, 
                        day13:monthlyreportday.day13, 
                        day14:monthlyreportday.day14, 
                        day15:monthlyreportday.day15, 
                        day16:monthlyreportday.day16, 
                        day17:monthlyreportday.day17, 
                        day18:monthlyreportday.day18, 
                        day19:monthlyreportday.day19, 
                        day20:monthlyreportday.day20, 
                        day21:monthlyreportday.day21, 
                        day22:monthlyreportday.day22, 
                        day23:monthlyreportday.day23, 
                        day24:monthlyreportday.day24, 
                        day25:monthlyreportday.day25, 
                        day26:monthlyreportday.day26, 
                        day27:monthlyreportday.day27, 
                        day28:monthlyreportday.day28, 
                        day29:monthlyreportday.day29, 
                        day30:monthlyreportday.day30, 
                        day31:monthlyreportday.day31, 
                        total:monthlyreportday.total, 
                        version:monthlyreportday.version, 
                                         
                        insertedby:_securityusersid,
                        updatedby:_securityusersid
                        })
                    )
                });
            }
            return Promise.all(prs);
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });

    }
}

    Ihasprovidermonthlyreport.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
            path: '/list',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });

    Ihasprovidermonthlyreport.list =(request)=>{
        return Ihasprovidermonthlyreport.find({
           where: { intakeserviceid: request.where.intakeserviceid },
          // where :{and:[{intakeserviceid:request.where.intakeserviceid},{activeflag:1}]},
            include: [
                {
                relation: 'monthlyreportdays'
            }
        ]
        })
    }

    Ihasprovidermonthlyreport.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Ihasprovidermonthlyreport.observe('access', (ctx, next) => util.access(ctx, next));
    Ihasprovidermonthlyreport.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
