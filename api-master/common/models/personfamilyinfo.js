'use strict';
const LOGGER = require("log4js").getLogger("personfamilyinfo");
const loopback = require('loopback');
var server = require('../../server/server');
const util = require('../utils/utils');
const moment = require('moment');
var app = require('../../server/server');

// Every list endpoint here wraps its rows with the totalcount that the SQL
// functions carry on each row. Shared so the identical block is not repeated
// per endpoint.
const withCount = rows => ({
    'data': rows,
    'count': (rows !== null && rows.length > 0) ? rows[0].totalcount : 0
});

// Shared failure path for the list endpoints: log locally, then hand the error
// to the central logger. Resolves rather than rethrows, which is what these
// endpoints have always done.
const logAndReturn = err => {
    LOGGER.error('>>>>ERROR:', err);
    return util.logError(err);
};

module.exports = function(Personfamilyinfo) {
   
    Personfamilyinfo.remoteMethod('addupdate', {
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

    Personfamilyinfo.addupdate = function(request, reqctx) {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        LOGGER.debug(request.personfamilyinfoid)
        if (request.personfamilyinfoid== null || request.personfamilyinfoid == undefined) {
            return Personfamilyinfo.create(request).then(res => {
                return res;
            });
        } else {

            var securityuserid = request && request.securityuserid?request.securityuserid:_securityusersid;
            var sql = "UPDATE personfamilyinfo SET activeflag=0,updatedby=$1 where personfamilyinfoid=$2";

            util.executeDBQuery(sql, [securityuserid,request.personfamilyinfoid])
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });


			var sqlq = "update person set maritalstatustypekey=$1 WHERE  personid=$2 ";

			util.executeDBQuery(sqlq, [request.maritalstatustypekey,request.personrelativeid])
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});


            return Personfamilyinfo.create(request).then(res => {
                return res;
            });

    }
 

}
   
    
   

    Personfamilyinfo.remoteMethod('list', {
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

    Personfamilyinfo.list =(request)=> {
        var page = request.page;
        var personid= request.where.personid;
        var limit = request.limit;
        var activeflag =1
        var sql = 'select * from getpersonfamilyinfo($1, $2, $3,$4)';

		return util.executeDBQuery(sql, [personid, page, limit,activeflag ])
		.then(withCount)
		.catch(logAndReturn);
    };

    Personfamilyinfo.remoteMethod('getpersonfamilyhistory', {
        http: {
            path: '/getpersonfamilyhistory',
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

    Personfamilyinfo.getpersonfamilyhistory  =(request)=> {
        var page = request.page;
        
        var limit = request.limit;
        var sql = 'select * from getpersonfamilyhistoryfilter($1, $2, $3)';

		return util.executeSecondaryNodeDBQuery(sql, [request.where, page, limit ])
		.then(withCount)
		.catch(logAndReturn);
    };

    Personfamilyinfo.remoteMethod('getpersonmobility', {
        http: {
            path: '/getpersonmobility',
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

    Personfamilyinfo.getpersonmobility = (request) => {
        var page = request.page;
        var limit = request.limit;

        var sql = 'select * from getpersonhlthmobilityspeechfilter($1, $2, $3)';

        return util.executeSecondaryNodeDBQuery(sql, [request.where, page, limit ])
        .then(withCount)
        .catch(logAndReturn);
    };


    Personfamilyinfo.remoteMethod('getpersonfeeding', {
        http: {
            path: '/getpersonfeeding',
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

    Personfamilyinfo.getpersonfeeding  =(request)=> {
        var page = request.page;
        var limit = request.limit;
        var sql = 'select * from getpersonhlthfeedingfilter($1, $2, $3)';

		return util.executeSecondaryNodeDBQuery(sql, [request.where, page, limit ])
		.then(withCount)
		.catch(logAndReturn);
    };

    Personfamilyinfo.remoteMethod('getpersonelimination', {
        http: {
            path: '/getpersonelimination',
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

    Personfamilyinfo.getpersonelimination  =(request)=> {
        var page = request.page;
        var limit = request.limit;
        var sql = 'select * from getpersonhltheliminationfilter($1, $2, $3)';

		return util.executeSecondaryNodeDBQuery(sql, [request.where, page, limit ])
		.then(withCount)
		.catch(logAndReturn);
    };

    Personfamilyinfo.remoteMethod('getpersonsleeping', {
        http: {
            path: '/getpersonsleeping',
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

    Personfamilyinfo.getpersonsleeping = (request) => {
        var page = request.page;
        var limit = request.limit;

        var sql = 'select * from getpersonhlthsleepingfilter($1, $2, $3)';

        return util.executeSecondaryNodeDBQuery(sql, [request.where, page, limit])
        .then(withCount)
        .catch(logAndReturn);
    };

    Personfamilyinfo.remoteMethod('history', {
        http: {
            path: '/history',
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

    Personfamilyinfo.history =(request)=> {
        var page = request.page;
        var personid= request.where.personid;
        var limit = request.limit;
        var activeflag =0
        var sql = 'select * from getpersonfamilyinfo($1, $2, $3,$4)';

		return util.executeDBQuery(sql, [personid, page, limit,activeflag ])
		.then(withCount)
		.catch(logAndReturn);
    };

     
    Personfamilyinfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personfamilyinfo.observe('access', (ctx, next) => util.access(ctx, next));
    Personfamilyinfo.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PFI',
    (ctx.isNewInstance || (ctx.instance && ctx.instance.personid)) ? ctx.instance.personid : ctx.where.personid));
    Personfamilyinfo.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};