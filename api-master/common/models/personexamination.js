'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const LOGGER = require("log4js").getLogger("personexamination");
module.exports = function (Personexamination) {
    Personexamination.remoteMethod('getPersonExamination', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query',
            },
            required: true,
        },
        http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Personexamination.getPersonExamination = (request) => {
        const pageno = request.page;
        const pagesize = request.limit;
        var totalcount = 0;
        var sql = 'select * from get_person_examination_list($1,$2,$3)';
        return util.executeSecondaryNodeDBQuery(sql, [JSON.stringify(request.where), pageno, pagesize])
            .then(data => {
                if (data !== null && data.length > 0) {totalcount = data[0].totalcount;}
                var result;
                result = {
                    'data': data,
                    'count': totalcount
                };
                return result;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };
    Personexamination.remoteMethod('addPersonExam', {
        http: {
            path: '/addPersonExam',
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

    Personexamination.addPersonExam = function (request, reqctx) {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
        request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
        return Personexamination.create(request)
            .then(data => data)
            .catch(err => util.logError(err));

    }



    Personexamination.remoteMethod('addupdate', {
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

    Personexamination.addupdate = function (request, reqctx) {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        if (request.personexaminationid == null || request.personexaminationid == undefined) {
            request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);

            return Personexamination.create(request)
                .then(res => {
                    return res;
                })
                .catch(err => util.logError(err));
        }
        else {
            request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            return Personexamination.updateAll({ personexaminationid: request.personexaminationid }, request)
                .catch(err => util.logError(err));
        }
    };

    Personexamination.remoteMethod('list', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            verb: 'get'
        },
        returns: {
            type: 'string',
            root: true
        }
    });

    Personexamination.list = request => {
        var page = request.page;
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var limit = 200;
        var sql = 'select * from getexaminationlistfilter($1,$2,$3)';

        return util.executeDBQuery(sql, [request.where, page, limit])
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }


    Personexamination.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personexamination.observe('access', (ctx, next) => util.access(ctx, next));
    Personexamination.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PEXAM',
    ctx.isNewInstance?ctx.instance.personid:ctx.data.personid));
    Personexamination.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};