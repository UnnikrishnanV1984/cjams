'use strict';
const LOGGER = require("log4js").getLogger("adoptionchecklist");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function (Adoptionchecklist) {


    Adoptionchecklist.addupdate = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        if (request.adoptionchecklistid !== undefined && request.adoptionchecklistid !== null) {
            return Adoptionchecklist.adoptionplanupdate(request, _securityusersid);
        } else {
            return Adoptionchecklist.adoptionplanadd(request, _securityusersid);
        }

    }



    Adoptionchecklist.adoptionplanadd = function (request, _securityusersid) {

        var v_adoptionchecklistid;
        var prs = [];
        return Adoptionchecklist.create({
            adoptionplanningid: request.adoptionplanningid,
            disclosuredate: request.disclosuredate,
            personinfomation: request.personinfomation,
            worker: request.worker,
            localdepartment: request.localdepartment,
            nonstaffmember: request.nonstaffmember,
            siblingage: request.siblingage,
            siblinginformation: request.siblinginformation,
            remarks: request.remarks,
            insertedby: _securityusersid,
            updatedby: _securityusersid
        }).then(respo => {
            v_adoptionchecklistid = respo.adoptionchecklistid;
            if (Array.isArray(request.adoptionchecklist)) {
                request.adoptionchecklist.map(checklist => {
                    prs.push(app.models.Adoptionchecklistdetails.create({
                        adoptionchecklistid: v_adoptionchecklistid,
                        checklistid: checklist.checklistid,
                        isselected: checklist.isselected,
                        remarks: checklist.remarks,
                        insertedby: _securityusersid,
                        updatedby: _securityusersid
                    }).catch(err => LOGGER.error(err))
                    )
                });
            }
            return Promise.all(prs);
        }).then(resp => {
            if (request.isDraft) {
                var responseJson = {};
                responseJson.adoptionplanningid = request.adoptionplanningid;
                responseJson.adoptionchecklistid = v_adoptionchecklistid;
                return responseJson;
            }
            else { 
            var status = 15;
            var comments='';
            if (util.isNullorEmpty(request.comments))
                {comments = request.comments;}
            

            var nofitymsg = 'Adoption Plan Submitted for review';
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)'; 
            if(!util.isNullorEmpty(request.intakeserviceid)){
                request.intakeserviceid = '';
            }
            return util.executeDBQuery(sql, [request.adoptionplanningid, _securityusersid, 'ADPR', status, comments, '', false, false, false, nofitymsg,'',request.servicecaseid,'',1])
            .then((data)=>{
                return data[0].routingintake;
            }).catch(err=>{
                LOGGER.error(err);
            });
            }
        }).then(data => {
            return routingintakeResp(request,v_adoptionchecklistid);
        })
            .catch(err => util.logError(err));
    }

    Adoptionchecklist.adoptionplanupdate = (request, _securityusersid) => {

        var prs = [];
        return Adoptionchecklist.updateAll({
            adoptionchecklistid: request.adoptionchecklistid
        },
            {
                adoptionplanningid: request.adoptionplanningid,
                disclosuredate: request.disclosuredate,
                personinfomation: request.personinfomation,
                worker: request.worker,
                localdepartment: request.localdepartment,
                nonstaffmember: request.nonstaffmember,
                siblingage: request.siblingage,
                siblinginformation: request.siblinginformation,
                remarks: request.remarks,
                updatedby: _securityusersid
            }).then(res => {         
                if (Array.isArray(request.adoptionchecklist)) {
                    request.adoptionchecklist.map(checklist => {
                        prs.push(app.models.Adoptionchecklistdetails.updateAll({
                            checklistid: checklist.checklistid,
                            adoptionchecklistid: request.adoptionchecklistid,
                        },{
                            isselected: checklist.isselected,
                            remarks: checklist.remarks,
                            updatedby: _securityusersid
                        }).catch(err => LOGGER.error(err))
                        )
                    });
                }
                return Promise.all(prs);
            }).then(resp => {
                if (request.isDraft) {
                    var responseJson = {};
                    responseJson.adoptionplanningid = request.adoptionplanningid;
                    responseJson.adoptionchecklistid = v_adoptionchecklistid;
                    return responseJson;
                }
                else { 
                var status = 15;
                var comments='';
                if (util.isNullorEmpty(request.comments))
                    {comments = request.comments;}
    
                var nofitymsg = 'Adoption Plan Submitted for review';
                var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)'; 
                if(!util.isNullorEmpty(request.intakeserviceid)){
                    request.intakeserviceid = '';
                }     
                
                return util.executeDBQuery(sql, [request.adoptionplanningid, _securityusersid, 'ADPR', status, comments, '', false, false, false, nofitymsg,'',request.servicecaseid,'',1]).then((resp1)=>{
                    return data[0].routingintake;
                }).catch(err=>{
                    LOGGER.error(err);
                });

                }
            }).then(data => {
                return routingintakeResp(request,v_adoptionchecklistid);
            }).catch(err => util.logError(err));

    }

    function routingintakeResp(request,v_adoptionchecklistid) {
        var responseJson = {};
        responseJson.adoptionplanningid = request.adoptionplanningid;
        responseJson.adoptionchecklistid = v_adoptionchecklistid;
        return responseJson;
    }

    Adoptionchecklist.remoteMethod('addupdate', {
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

    
    Adoptionchecklist.getadoptionchecklist = function (request) {

        var sql = 'select * from getadoptionchecklist($1)';
        var params = [request.where.adoptionplanningid];

        return util.executeDBQuery(sql, params)
          .then(data => {
            return data;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });

      };
      
      Adoptionchecklist.remoteMethod('getadoptionchecklist', {
        accepts: {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        },
        http: {
          path: '/getadoptionchecklist',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });

      Adoptionchecklist.validateadoptionplan = function (request) {

        var sql = 'select * from validateadoptionplan($1)';
        var params = [request.where.intakeserviceid];

        return util.executeDBQuery(sql, params)
          .then(data => {
            return data[0];
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });

      };
      
      Adoptionchecklist.remoteMethod('validateadoptionplan', {
        accepts: {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        },
        http: {
          path: '/validateadoptionplan',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });


    Adoptionchecklist.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionchecklist.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionchecklist.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}    

