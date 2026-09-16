'use strict';
const LOGGER = require("log4js").getLogger("Personemployment");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Personemployment) {

    Personemployment.remoteMethod('list', {
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

    Personemployment.list =(request)=> {
        var page = request.page;
        if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
		LOGGER.debug('Page: ' + page);
        var personid = request.where.personid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from Personemployment where activeflag=1 and personid=$1 limit $2 offset $3';

      return util.executeDBQuery(sql,[personid,request.page,request.skip])
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
		.catch(err => util.logError(err));
    };


    Personemployment.remoteMethod('addupdate', {
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


 

    Personemployment.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const insertedon = new Date().toLocaleString();
 
        if (request.personemploymentid === undefined || request.personemploymentid == null) {
            request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.insertedon = insertedon;
            
            return Personemployment.create(request);
            
        } else {
            return Personemployment.updateAll({
                personemploymentid: request.personemploymentid             
        }, {
            promotedemploymentprogramname:request.promotedemploymentprogramname,
            promotedemploymentprogramstartdate:request.promotedemploymentprogramstartdate,
             enddate:request.enddate,
             personid:request.personid, 
             clientmergeid: request.personid, 
             streetnotes:request.streetnotes,        
            activeflag: request.activeflag,
            updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid)
        }).catch(err => util.logError(err));
       }
    };
 
       
    Personemployment.remoteMethod ('getactivitypersonnotification',{
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
          type : 'string',
          root : true
        }
      });   

      Personemployment.getactivitypersonnotification = function (request) {
            var person = request.where;

        var sql = 'select * from getactivitypersonnotification ($1)';
        return util.executeDBQuery(sql, [person])
          .then(data => {
            return data;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
      };



    
    Personemployment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personemployment.observe('access', (ctx, next) => util.access(ctx, next));
    Personemployment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
