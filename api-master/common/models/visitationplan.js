'use strict';
const LOGGER = require("log4js").getLogger("visitationplan");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Visitationplan) {

    Visitationplan.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Visitationplan.observe('access', (ctx, next) => util.access(ctx, next));
    Visitationplan.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

    Visitationplan.addupdate = (request,reqctx) => {
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
        const currentDate = new Date().toLocaleString();
        if (request.visitationplanid == undefined || request.visitationplanid == null) {
            request.insertedby = (request && request.securityuserid?request.securityuserid: suserid)
            request.insertedon = currentDate;
            request.updatedby = (request && request.securityuserid?request.securityuserid: suserid);
            request.updatedon = currentDate;
            request.activeflag = true;
            return Visitationplan.create(request).then(res => {
                request.visitationplanid = res.visitationplanid;
                if (request.visitationplanclients && request.visitationplanclients.length > 0) {
                request.visitationplanclients.forEach(element => {
                    const vpclientsreq = {};
                    vpclientsreq.personid = element;
                    vpclientsreq.visitationplanid = res.visitationplanid;
                    return app.models.Visitationplanclients.create(vpclientsreq).then(res1 => {
                        LOGGER.debug(res1);
                    }
                        )
                });
                }

            })
        } 
        else {
            return Visitationplan.updatevisitationplan(request,reqctx).
            then(resp => resp);
        }
    };

    Visitationplan.updatevisitationplan = (request,reqctx, response) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            suserid = reqctx.req.headers.securityusersid
        }
        var updatedby = (request && request.securityuserid?request.securityuserid: suserid);
        var sql = 'UPDATE Visitationplan SET activeflag=0, updatedon = now(), updatedby = $1 WHERE visitationplanid = $2';
        var sql1 = 'UPDATE visitationplanclients SET activeflag=0, updatedon = now(), updatedby = $1 WHERE visitationplanid = $2';
        return util.executeDBQuery(sql, [updatedby,request.visitationplanid])
        .then(data => {
            return util.executeDBQuery(sql1, [updatedby,request.visitationplanid]);
        }).then (data => {
            request.visitationplanid = null;
            if (request.activeflag === 0) {
                return {'response': 'Visitation Plan Deleted'};
            } else {
                return Visitationplan.addupdate(request,reqctx);
            }
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    }

    Visitationplan.listallvisitation = function(request) {
        var sortby = request.where && request.where.sortby ? request.where.sortby : 'clientname';
        var sortdir = request.where && request.where.sortdir ? request.where.sortdir : 'asc';
        return Visitationplan.find({
            nolimimt:true,
            where: { and:[{caseid: request.where.caseid } , {activeflag : 1}] },
            include: [
            {
                relation: 'person',
                scope: {
                    fields: ['personid','firstname','middlename','lastname','prefx','suffix']
                }
            },
            {
                relation: 'visitationplanclients',
                scope: {
                    nolimimt:true,
                    fields: ['visitplanclntid',
                        'visitationplanid',
                        'personid',
                        'activeflag'
                        ],
                    include: [{
                        relation: 'person',
                        scope: {
                            fields: [
                                'prefx',
                                'firstname',
                                'middlename',
                                'lastname',
                                'suffix',
                                'activeflag'
                            ]
                        }
                    }]
                }
            }]
        })
        .then(data =>{
            const visitationplans = JSON.parse(JSON.stringify(data));
            return visitationplans.sort( function (item1,item2) {
                var a=item1,b=item2;
                if(sortdir == 'asc'){
                    a=item2;
                    b=item1;
                }
                if(sortby == 'clientname') {
                    const aname = getName(a);
                    const bname = getName(b); 
                    return String(aname).localeCompare(String(bname));
                }
                else {
                    return sortedData(a, b, sortby);
                }
            });
        })
        .catch(err => err);
        
    }

    function sortedData(a, b, sortby){
        if(a[sortby] == null){
            return -1;
        }
        if(b[sortby] == null){
            return 1;
        }
        return a[sortby] > b[sortby] ? 1 : -1;
    }

    function getName(a){
        let personmiddlename = ''; 
        if( a?.person?.middlename){
            personmiddlename = a.person.middlename + ' ';
        }
        return a && a.person ? a.person.firstname + ' ' + personmiddlename + a.person.lastname : '';
    }

    Visitationplan.remoteMethod('listallvisitation', {
        http: {
            path: '/listallvisitation',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Visitationplan.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        returns: {
            type: 'object',
            root: true
        }
    });

}

