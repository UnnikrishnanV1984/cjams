'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Adoptionrevision) { 
 
    Adoptionrevision.remoteMethod('createraterevision', {
        http: {
                path: '/createraterevision',
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

    Adoptionrevision.createraterevision = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
        var result;
        if (request.adoptionagreementid) {
            var sql = 'select * from validateadoptionagreementrate($1,$2,$3)';
            return util.executeDBQuery(sql,[request.adoptionagreementid,request.startdate,request.enddate])
            .then(data => {
                if (data && data.length && data[0].statuscode === 200) {
                    var adoptionagreementrateid;
                    var securityusersid =  _securityusersid;
                    request.activeflag = 1;               
                    request.insertedby = securityusersid;
                    request.status = 'Review';
                
                    var genid = "select * from gen_random_uuid()"; //@TM: use generated subsidy rate id if unavailable

                    return util.executeDBQuery(genid, [])
                    .then((rateid)=>{
                        var generatedId = JSON.parse(JSON.stringify(rateid));
                        adoptionagreementrateid = request.adoptionagreementrateid ? request.adoptionagreementrateid : generatedId[0].gen_random_uuid;
                    })
                    .then(data1 => {
                        // De-activate any existing review records
                        Adoptionrevision.update(
                            {   subsidyagreementrateid: adoptionagreementrateid,
                                approvalstatustypekey: '3045',
                                activeflag: 1
                            },
                            {   activeflag: 0 }
                        ).then(res => {
                            // Create revision - Rate record should be created only after approval
                            Adoptionrevision.create({
                                adoptionid: request.adoptionplanningid,
                                subsidyagreementid: request.adoptionagreementid,
                                subsidyagreementrateid: adoptionagreementrateid,
                                transactiondate: request.transactiondate,
                                providerid: request.provider_id,
                                agreementstartdate: request.startdate,
                                agreementenddate: request.enddate,
                                comments: request.notes,
                                paymentamt: request.paymentamout,
                                insertedby: securityusersid,
                                updatedby: securityusersid
                            });
                            return data1;
                        });
                    }).catch(err=>{
                        LOGGER.error(err);
                    });
                } else {
                    return result.status_description;
                }
            }).catch(err=>{
                LOGGER.error(err);
            });
        }
        return Promise.resolve('Invalid request');
    }

    Adoptionrevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionrevision.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionrevision.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    