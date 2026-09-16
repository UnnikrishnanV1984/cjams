'use strict';
const LOGGER = require("log4js").getLogger("tprrecommendation");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Tprrecommendation) {

    Tprrecommendation.add = function (request,reqctx) {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        if (request.tprrecommendationid) {
            if (Array.isArray(request.tprrecommendationchecklist)) {
                const prs = [];
                request.tprrecommendationchecklist.map(checklist => {
                    if (checklist.checklistid === '24b96c2b-6a6a-4f5c-aaab-1b702fd5e549' && request.child15to22CheckboxChanged) {
                        prs.push(app.models.Tprrecommendationchecklist.updateAll(
                            {
                                tprrecommendationid: request.tprrecommendationid,
                                activeflag: true,
                                checklistid: checklist.checklistid
                            },
                            {
                                isselected: checklist.isselected,
                                updatedby: suserid,
                                updatedon: new Date()
                            }
                        ).then(res => {
                            util.auditLogSingleSave(request.tprrecommendationid, 'TPRREC1522', {
                                checklistid: checklist.checklistid,
                                isselected: checklist.isselected
                            });
                            return res;
                        }).catch(err => LOGGER.error(err)));
                    }
                });
                return Promise.all(prs);
            }
        }
        else{
        const prs = []; 
        var v_tprrecommendationid;
        return Tprrecommendation.create({
            intakeservicerequestactorid: request.intakeservicerequestactorid,
            intakeserviceid: request.intakeserviceid,
            servicecaseid: request.servicecaseid,
            permanencyplanid: request.permanencyplanid,
            isrecommended: request.isrecommended,
            reasontypekey: request.reasontypekey,
            remarks: request.remarks,
            intakeservreqcourtorderid: request.intakeservreqcourtorderid,
            insertedby: suserid,
            updatedby: suserid
        }).then(respo => {
            v_tprrecommendationid = respo.tprrecommendationid;
            if (Array.isArray(request.tprrecommendationchecklist)) {
                request.tprrecommendationchecklist.map(checklist => {
                    prs.push(app.models.Tprrecommendationchecklist.create({
                        tprrecommendationid: v_tprrecommendationid,
                        checklistid: checklist.checklistid,
                        isselected: checklist.isselected,
                        insertedby: suserid,
                        updatedby: suserid
                        }).catch(err => LOGGER.error(err))
                    );
                    saveAuditlogs(checklist, request, v_tprrecommendationid);
                });
            }
            return Promise.all(prs);
        })
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }
        return Promise.resolve([]);
    }

    function saveAuditlogs(checklist, request, v_tprrecommendationid){
        if(checklist.checklistid === '24b96c2b-6a6a-4f5c-aaab-1b702fd5e549' && request.child15to22CheckboxChanged){
            util.auditLogSingleSave(v_tprrecommendationid,'TPRREC1522',{checklistid: checklist.checklistid,
                isselected: checklist.isselected});
        }
    }

    Tprrecommendation.remoteMethod('add', {
        accepts:[ {
            arg: 'data',
            type: 'object',
            http: { source: 'body' }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        http: {
            'verb': 'post',
            'path': '/add'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Tprrecommendation.gettprrecommendation = function(request) {
        var sql = 'select * from gettprrecommendation($1,$2)';
        return util.executeDBQuery(sql, [request.where.servicecaseid, request.where.permanencyplanid])
        .then(data => {
            return JSON.parse(JSON.stringify(data[0]));
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      }
      
    Tprrecommendation.remoteMethod('gettprrecommendation', {
        http: {
            path: '/gettprrecommendation',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Tprrecommendation.remoteMethod('gettprrecommendationbyperson', {
        http: {
            path: '/gettprrecommendationbyperson',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Tprrecommendation.gettprrecommendationbyperson = function(request) {

        var sql = 'select * from gettprrecommendationbyperson($1,$2, $3)';
        return util.executeDBQuery(sql, [request.where.servicecaseid, request.where.permanencyplanid, request.where.personid])
        .then(data => {
            return JSON.parse(JSON.stringify(data[0]));
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Tprrecommendation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tprrecommendation.observe('access', (ctx, next) => util.access(ctx, next));
    Tprrecommendation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};