'use strict';
const LOGGER = require("log4js").getLogger("serviceplanchild");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const http = require('http');

module.exports = function(Serviceplanchild) {

    Serviceplanchild.addupdate = (request,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        const insertedon = new Date().toLocaleString();

        if (request.serviceplanchildid == undefined || request.serviceplanchildid == null) {
            request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
            request.insertedon = insertedon;
            request.activeflag = true;
            return Serviceplanchild.create(request);
        } else {
            return Serviceplanchild.updateserviceplanchild(request,suserid);
        }
    };

    Serviceplanchild.updateserviceplanchild = (request,suserid) => {

        return Serviceplanchild.updateAll({
            serviceplanchildid: request.serviceplanchildid,
            serviceplancaseid: request.serviceplancaseid

        }, {
            serviceplanname: request.serviceplanname,
            startdate: request.startdate,
            enddate: request.enddate,
            activeflag: request.activeflag,
            numberofdays: request.numberofdays,
            status:request.status,
            updatedby: (request && request.securityuserid?request.securityuserid: suserid)
        }).then(data => {
            return data;
        })
    };


    Serviceplanchild.listByAllRelation= function(request) {
        LOGGER.debug("caseID" + request.where.caseid);
	    if(request.where && request.where.caseid !== undefined) {
            return Serviceplanchild.find({
                where:{serviceplanchildid:request.where.caseid},
                include:{
                relation:'serviceplanfocus',
                scope:{
                    fields:['serviceplanfocusid',
                        'serviceplanchildid',
                        'activeflag'],
                        include:{
                            relation:'serviceplanaction',
                            scope:{
                                fields:[
                                    'serviceplanactionid',
                                    'serviceplanfocusid',
                                    'serviceplanactionname',
                                    'personresponsible',
                                    'startdate',
                                    'enddate',
                                    'status',
                                    'insertedby',
                                    'insertedon',
                                    'updatedby',
                                    'updatedon',
                                    'activeflag'
                                ],
                                include:{
                                    relation:'serviceplanoutcome',
                                    scope:{
                                        fields:[
                                            'serviceplanoutcomeid',
                                            'serviceplanactionid',
                                            'serviceplanoutcomename'
                                           ],
                                    }
                                }
                            }
                        }
                }
                }              
            }).then(resp => {
                        const data = JSON.parse(JSON.stringify(resp));
                        LOGGER.debug("data" + JSON.stringify(resp));
                        return data;
                   })
                   .catch(err => err);	
	    }
	     
        return Promise.resolve([]);
    };	  
    Serviceplanchild.list = function(request) {
        if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
        var serviceplanchildid = request.where.serviceplanchildid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from serviceplanchild where serviceplanchildid=$1 limit $2 offset $3';

		return util.executeDBQuery(sql, [serviceplanchildid, request.page, request.skip])
			.then(data => {
                    if (data!==null && data.length>0) {totalcount= data[0].totalcount;}
                    var result;
                    result = {
                        'data' : data,
                        'count' : totalcount
                    };
					return result;
			})
			.catch(err => util.logError(err));
    };
 
    Serviceplanchild.getAssessment = (request) => {

        const sql = `SELECT a.insertedon,at.external_templateid,at.name,a.submissionid,(a.submissiondata :: json), coalesce(a.ischildsafe,false),a.assessmentstatustypekey,a.intakeservicerequestactorid
        from assessment a
        JOIN assessmenttemplate at on a.assessmenttemplateid = at.assessmenttemplateid and a.activeflag =1 and at.activeflag = 1
        where a.objectid = $1 and lower(at.name) = lower($2) and lower(a.assessmentstatustypekey)=lower($3)
        order by a.insertedon desc limit 1`;

        var result;

        return util.executeDBQuery(sql, [request.where.objectid,request.where.templatename,request.where.status])
            .then(data => {
                result = {
                    'data': data
                };
                return result;
            })
            .catch(err => err);
    };

    Serviceplanchild.remoteMethod('addupdate', {
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
          } ],
        returns: {
            type: 'object',
            root: true
        }
    });


    Serviceplanchild.remoteMethod('list', {
        http: {
            path: '/list',
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

    Serviceplanchild.remoteMethod('listByAllRelation', {
        http: {
            path: '/listbyallrelation',
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
 
    Serviceplanchild.remoteMethod('getAssessment', {
        http: {
            path: '/getAssessment',
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
    Serviceplanchild.remoteMethod('serviceplanchildlist', {
        http: {
            path: '/serviceplanchildlist',
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

    Serviceplanchild.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanchild.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanchild.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}
