'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Adoptionemotional) {
    Adoptionemotional.remoteMethod('addupdate', {
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

    Adoptionemotional.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        if(request.adoptionemotionalid !== undefined && request.adoptionemotionalid !== null) {
            return Adoptionemotional.updateadoptionemotional(request, _securityusersid);
        } else {
            return Adoptionemotional.addadoptionemotional(request, _securityusersid);
        }
    }

    Adoptionemotional.addadoptionemotional = function(request, _securityusersid)
    {
        var securityusersid = (request?.securityuserid ? request.securityuserid : _securityusersid);
        const prs = [];
        var v_adoptionemotionalid;
        var adoptionemotionaldetails = request.adoptionemotionaldetails;
        return Adoptionemotional.create({
            adoptionplanningid: request.adoptionplanningid,
            notes: request.notes,
            isfosterparents: request.isfosterparents,
            isadoptivefamily: request.isadoptivefamily,
            insertedby: securityusersid,
            updatedby: securityusersid
        }).then(data => {
            v_adoptionemotionalid = data.adoptionemotionalid;
            if (Array.isArray(adoptionemotionaldetails)) {
                adoptionemotionaldetails.forEach(element => {
                    prs.push(
                        app.models.Adoptionemotionaldetails.create({
                            adoptionemotionalid: v_adoptionemotionalid,
                            intakeservicerequestactorid: element.intakeservicerequestactorid,
                            childimportance: element.childimportance,
                            remarks: element.remarks,
                            insertedby: securityusersid,
                            updatedby: securityusersid                        })
                    )
                })
            }
            return Promise.all(prs);
        }).then(respo => respo)
        .catch(err => util.logError(err));
    }

    Adoptionemotional.updateadoptionemotional = function(request, _securityusersid)
    {
        const prs = [];
        var v_adoptionemotionalid;
        var adoptionemotionaldetails = request.adoptionemotionaldetails;
        const securityuserid = request.securityuserid ? request.securityuserid : _securityusersid;
        const v_securityusersid = request.v_securityusersid ? request.v_securityusersid : _securityusersid;
        return Adoptionemotional.updateAll(
            { adoptionemotionalid: request.adoptionemotionalid },
            {
                notes: request.notes,
                isfosterparents: request.isfosterparents,
                isadoptivefamily: request.isadoptivefamily,
                updatedby: securityuserid
            }).then(res => {
                var sql = 'select * from updateadoptionemotional($1)';
                return util.executeDBQuery(sql, [request.adoptionemotionalid])
                .then(data => {
                    return data;
                })
          }).then(resp=>{
                v_adoptionemotionalid = request.adoptionemotionalid;
                if(Array.isArray(adoptionemotionaldetails)) {
                    adoptionemotionaldetails.forEach(element => {
                    prs.push(
                        app.models.Adoptionemotionaldetails.create({
                            adoptionemotionalid: v_adoptionemotionalid,
                            intakeservicerequestactorid: element.intakeservicerequestactorid,
                            childimportance: element.childimportance,
                            remarks: element.remarks,
                            insertedby: v_securityusersid,
                            updatedby: v_securityusersid                        })
                    )
                })
            }
            return Promise.all(prs);
        }).then(datas => 'UPDATED SUCCESSFULLY')
        .catch(err => util.logError(err));
    }

    Adoptionemotional.remoteMethod('list', {
        http: {
            path: '/list',
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

    Adoptionemotional.list =(request)=> {
        var adoptionplanningid = request.where.adoptionplanningid;
        var sql = 'select * from getadoptionemotional($1)';
		return util.executeDBQuery(sql, [adoptionplanningid])
		.then(datas => datas)
		.catch(err => util.logError(err));
    };

    Adoptionemotional.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionemotional.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionemotional.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    