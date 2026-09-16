'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Kinshipcare) {
    /**Kinshipcare add */
    Kinshipcare.remoteMethod('addupdate', {
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

    Kinshipcare.addupdate = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        if(request.kinshipcareid !== undefined && request.kinshipcareid !== null) {
            return Kinshipcare.updatekinshipcare(request, _securityusersid);
        } else {
            return Kinshipcare.addkinship(request, _securityusersid);
        }
    }

    Kinshipcare.addkinship = function(request, _securityusersid)
    {
        var checklist = request.checklist;
        var documents = request.documents;
        var comments;
        if(request.comments !== undefined && request.comments !== null) 
            {comments = request.comments;}
        else 
            {comments = '';}            
        var prs = [];
        var v_kinshipcareid;
        return Kinshipcare.create({
            intakeserviceid:request.intakeserviceid,
            primaryisractorid:request.primaryisractorid,
            secondaryisractorid:request.secondaryisractorid,
            acceptcharacteristics:request.acceptcharacteristics,
            cpsclearance:request.cpsclearance,
            cjsinfo:request.cjsinfo,
            dhhreport:request.dhhreport,
            isreceiveddisciplinepolicy:request.isreceiveddisciplinepolicy,
            isapproveddisciplinepolicy:request.isapproveddisciplinepolicy,
            insertedby:_securityusersid,
            updatedby: _securityusersid  
        }).then(resp=>{
            v_kinshipcareid = resp.kinshipcareid;
            if(Array.isArray(checklist)) {
                checklist.forEach(element => {
                   prs.push(
                        app.models.Kinshipcarechecklist.create({
                            kinshipcareid: v_kinshipcareid,
                            checklistid:element.checklistid,
                            insertedby:_securityusersid,
                            updatedby: _securityusersid  
                        })
                    )
                })
            }
            if(Array.isArray(documents)) {
                documents.forEach(element => {
                   prs.push(
                        app.models.Kinshipcaredocuments.create({
                            kinshipcareid: v_kinshipcareid,
                            documentpropertiesid:element.documentpropertiesid,
                            insertedby: _securityusersid,
                            updatedby: _securityusersid  
                        })
                    )
                })                
            }
            return Promise.all(prs);
        }).then(resp => {
            var status = 15;
            var nofitymsg = 'Kinshipcare Submitted for review';
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
            return util.executeDBQuery(sql, [request.intakeserviceid, _securityusersid, 'KINR', status, comments, '', false, false, false, nofitymsg,'',request.intakeserviceid])
                .then(data => data[0].routingintake);
        }).then(data => {
            var responseJson = {};
            responseJson.intakeserviceid=request.intakeserviceid;
            responseJson.kinshipcareid=v_kinshipcareid;
            return responseJson;
        })
        .catch(err => util.logError(err));
    }

    Kinshipcare.updatekinshipcare=(request, _securityusersid)=>{
        var checklist = request.checklist;
        var documents = request.documents;
        var prs = [];
        var v_kinshipcareid;
        if (request.kinshipcareid!=null && request.kinshipcareid!==undefined)
        {
            return Kinshipcare.updateAll(
                {kinshipcareid:request.kinshipcareid},
                {
                primaryisractorid:request.primaryisractorid,
                secondaryisractorid:request.secondaryisractorid,
                acceptcharacteristics:request.acceptcharacteristics,
                cpsclearance:request.cpsclearance,
                cjsinfo:request.cjsinfo,
                dhhreport:request.dhhreport,
                isreceiveddisciplinepolicy:request.isreceiveddisciplinepolicy,
                isapproveddisciplinepolicy:request.isapproveddisciplinepolicy,
                updatedby:_securityusersid
            }).then(res =>{
                  var sql = 'select * from updatekinship($1)';
                return util.executeDBQuery(sql,[request.kinshipcareid])
                    .then(data => {
                     return data;
                    })
            }).then(resp=>{
                v_kinshipcareid = request.kinshipcareid;
                if(Array.isArray(checklist)) {
                    checklist.forEach(elem => {
                       prs.push(
                            app.models.Kinshipcarechecklist.create({
                                kinshipcareid: v_kinshipcareid,
                                checklistid:elem.checklistid,
                                insertedby: _securityusersid,
                                updatedby: _securityusersid  
                            })
                        )
                    })
                }
                if(Array.isArray(documents)) {
                    documents.forEach(ele => {
                       prs.push(
                            app.models.Kinshipcaredocuments.create({
                                kinshipcareid: v_kinshipcareid,
                                documentpropertiesid:ele.documentpropertiesid,
                                insertedby: _securityusersid,
                                updatedby: _securityusersid  
                            })
                        )
                    })                
                }
                return Promise.all(prs);
            }).then(data => 'UPDATED SUCCESSFULLY').catch(err => util.logError(err));
        }
    }

    Kinshipcare.list = (request) => {
        var v_resp;
        return Kinshipcare.find({
            where: { intakeserviceid: request.where.intakeserviceid },
            fields:['kinshipcareid','intakeserviceid','primaryisractorid','secondaryisractorid','acceptcharacteristics','cpsclearance','cjsinfo','dhhreport','isreceiveddisciplinepolicy','isapproveddisciplinepolicy','activeflag'],
            include: [{
                    relation: 'kinshipcaredocuments',
                    scope:{
                        fields:['kinshipcaredocumentsid','documentpropertiesid','kinshipcareid'],
                        include: {
                            relation: 'documentproperties',
                            scope:{
                                fields:['documentpropertiesid','documenttypekey','documentdate','filename','originalfilename','title','description','intakenumber']
                            }
                        }
                    }
                },
                {
                    relation: 'kinshipcarechecklist',
                  
                    scope: {
                        fields:['kinshipcarechecklistid','checklistid','kinshipcareid'],
                        include: {
                            relation: 'checklist',
                            scope:{
                                fields:['checklistid','checklistname','description','checklisttypekey'],
                            }
                        }
                    }
                }]
        }).then(data =>{
            v_resp = data;
            request.where.eventcode = 'KINR';
            return app.models.Routing.getroutinginfo(request);
        }).then(resp => {
            var responseJson = {};
            responseJson.routinginfo=resp;
            responseJson.kinshipcarelist=v_resp;
            return responseJson;
        })
        .catch(err => err);
	}

    Kinshipcare.remoteMethod('list', {
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
    Kinshipcare.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Kinshipcare.observe('access', (ctx, next) => util.access(ctx, next));
    Kinshipcare.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};