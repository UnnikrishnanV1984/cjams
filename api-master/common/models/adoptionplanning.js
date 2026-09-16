'use strict';
const LOGGER = require("log4js").getLogger("adoptionplanning");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function (Adoptionplanning) {

    Adoptionplanning.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        if (request.adoptionplanningid !== undefined && request.adoptionplanningid !== null) {
            return Adoptionplanning.updateadoptionplan(request, _securityusersid);
        } else {
            return Adoptionplanning.addadoptionplan(request, _securityusersid);
        }
    }

    Adoptionplanning.addadoptionplan = function (request, _securityusersid) {
        const prs = [];
        var v_adoptionplanningid;
        const currentDate = new Date().toLocaleString();
        const securityuserid = (request.securityuserid ? request.securityuserid : _securityusersid);            //SonarQube complexity fix - used constant instead of duplicating 
        const vsecurityusersid = (request.v_securityusersid ? request.v_securityusersid : _securityusersid);
        return Adoptionplanning.create({
            intakeserviceid: request.intakeserviceid,
            intakeservicerequestactorid: request.intakeservicerequestactorid,
            isnoeffort: request.isnoeffort,
            isexceptiongranted: request.isexceptiongranted,
            dateofexceptiongranted: request.dateofexceptiongranted,
            remarks: request.remarks,
            permanencyplanid:request.permanencyplanid,
            adoptiondate:currentDate,
            servicecaseid :request.servicecaseid,
            insertedby: securityuserid,
            updatedby: securityuserid
        }).then(resp => {
            v_adoptionplanningid = resp.adoptionplanningid;
            if (Array.isArray(request.adoptionefforts)) {
                request.adoptionefforts.map(element => {
                    prs.push(app.models.Adoptionefforts.create({
                        adoptionplanningid: v_adoptionplanningid,
                        notes: element.notes,
                        effortdate: element.effortdate,
                        efforttype: element.efforttype,
                        insertedby: vsecurityusersid,
                        updatedby: vsecurityusersid
                    }).catch(err => LOGGER.error(err))
                    )
                });
                return Promise.all(prs);
            } else {
                return v_adoptionplanningid;
            }
        }).then(data => {
            return v_adoptionplanningid;
        })
            .catch(err => util.logError(err));

    }

    Adoptionplanning.updateadoptionplan = function (request, _securityusersid) {
        const prs = [];
        const currentDate = new Date().toLocaleString();
        const securityuserid = (request.securityuserid ? request.securityuserid : _securityusersid);         //SonarQube complexity fix - used constant instead of duplicating 
        return Adoptionplanning.updateAll({
            adoptionplanningid: request.adoptionplanningid
        }, {
                intakeserviceid: request.intakeserviceid,
                intakeservicerequestactorid: request.intakeservicerequestactorid,
                isnoeffort: request.isnoeffort,
                isexceptiongranted: request.isexceptiongranted,
                dateofexceptiongranted: request.dateofexceptiongranted,
                permanencyplanid:request.permanencyplanid,
                servicecaseid :request.servicecaseid, 
                adoptiondate:currentDate,   
                remarks: request.remarks,
                updatedby: securityuserid,
            }).then(res => {
                var sql = 'select * from updateadoptionplanning($1)';
                return util.executeDBQuery(sql, [request.adoptionplanningid]);
            }).then(resp => {
                if (Array.isArray(request.adoptionefforts)) {
                    request.adoptionefforts.map(element => {
                        prs.push(app.models.Adoptionefforts.create({
                            adoptionplanningid: request.adoptionplanningid,
                            notes: element.notes,
                            effortdate: element.effortdate,
                            efforttype: element.efforttype,
                            insertedby: securityuserid,
                            updatedby: securityuserid
                        }).catch(err => LOGGER.error(err))
                        )
                    });
                }
                return Promise.all(prs);
            }).then(data => {
                return "Adoption Planning Updated Successfully";
            })
            .catch(err => util.logError(err));
    }
    Adoptionplanning.remoteMethod('addupdate', {
        accepts: [{
            arg: 'data',
            type: 'object',

            http: { source: 'body' }
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        http: {
            'verb': 'post',
            'path': '/addupdate'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Adoptionplanning.getadoptionplanning = function (request) {

        var sql = 'select * from getadoptionplanning($1)';
        var params = [request.where.permanencyplanid];

        return util.executeDBQuery(sql, params)
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });

    };

    Adoptionplanning.remoteMethod('getadoptionplanning', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            path: '/getadoptionplanning',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });
    
    Adoptionplanning.updateadoptionnarrative = function (request, reqctx) {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        } 
        return Adoptionplanning.updateAll({
            adoptionplanningid: request.adoptionplanningid
        }, {
                adoptiondate: request.adoptiondate,
                narrative: request.narrative, 
                updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid)
            }).then(data =>{
                return "Adoption Narrative Updated Successfully";})
                .catch(err => util.logError(err));
        }

        Adoptionplanning.remoteMethod('updateadoptionnarrative', {
            accepts: [{
                arg: 'data',
                type: 'object',
    
                http: { source: 'body' }
            }, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
            http: {
                'verb': 'post',
                'path': '/updateadoptionnarrative'
            },
            returns: {
                type: 'Object',
                root: true
            }
        });

    Adoptionplanning.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionplanning.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionplanning.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}    
