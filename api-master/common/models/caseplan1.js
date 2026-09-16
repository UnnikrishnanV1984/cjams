'use strict';
const LOGGER = require("log4js").getLogger("caseplan1");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Caseplan1) {

    Caseplan1.remoteMethod('list', {
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

    Caseplan1.list =(request)=> {
        if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
        var personid = request.where.personid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from caseplan1 where activeflag=1 and personid=$1 limit $2 offset $3';

        return util.executeDBQuery(sql, [personid,request.page,request.skip])
            .then(data => {
                if (data !== null && data.length > 0) {
                    totalcount = data[0].totalcount;
                    var result;
                    result = {
                        'data': data,
                        'count': totalcount
                    };
                    return result;
                }
            })
		.then(data => data)
		.catch(err => util.logError(err));
    };


   Caseplan1.remoteMethod('addupdate', {
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
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        returns: {
            type: 'object',
            root: true
        }
    });


 

      Caseplan1.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  	
        const insertedon = new Date().toLocaleString();
 
        if (request.caseplan1id == undefined || request.caseplan1id == null) {
            request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.insertedon = insertedon;
            request.activeflag = true;
            return Caseplan1.create(request);
            
        } else {
            return Caseplan1.updateAll({
            caseplan1id: request.caseplan1id             
        }, {
             placement:request.placement,
             familyhistory:request.familyhistory,
             childdesc:request.childdesc,
             personid:request.personid,
             
           //  caseid:request.intakeservreqchildremovalid  ,    
            activeflag: request.activeflag,
            updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid),
            updatedon:  new Date().toLocaleString()
        }).catch(err => util.logError(err));
       }
    };
 
    
    
    Caseplan1.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Caseplan1.observe('access', (ctx, next) => util.access(ctx, next));
    Caseplan1.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
