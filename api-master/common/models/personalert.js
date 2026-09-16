'use strict';
const LOGGER = require("log4js").getLogger("personalert");
const util = require('../utils/utils');
var app = require('../../server/server');
var server = require('../../server/server');

const withCount = rows => {
    const result = {
        'data': rows,
        'count': (rows !== null && rows.length > 0) ? rows[0].totalcount : 0
    };
    LOGGER.debug(result);
    return result;
};

module.exports = function(Personalert) {

    Personalert.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Personalert.add = function(request)
    {  
        return Personalert.create(request).then(data => {
            return data;
		}).catch(err => util.logError(err));
    };

    Personalert.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });
   
    Personalert.list = function(request, reqctx)
    {   
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const securityusersid =(request && request.securityuserid?request.securityuserid: _securityusersid);
        LOGGER.debug(request.where.personid+"personid");
        const limit = request.limit;
        const skip = request.page;
        const activeflag =1;

        var sql = "select * from getpersonalertlist($1,$2,$3,$4,$5)";

        return util.executeDBQuery(sql,[request.where.personid,skip,limit,activeflag,securityusersid])
          .then(withCount)
          .catch(err => util.logError(err));
        };

        Personalert.remoteMethod('listda', {
            http: {
                path: '/listda',
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
       
        Personalert.listda = function(request)
        {
            var sql = "select * from getpersonalertlistda($1,$2,$3)"

            return util.executeDBQuery(sql,[request.where.personalertid,request.page,request.limit])
              .then(res =>{
                return res
              })
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              });
            };

        

        
        
    

    Personalert.remoteMethod('history', {
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

    Personalert.history =(request)=> {

        LOGGER.debug(request.where.personid+"personid");
        const limit = request.limit;
        const skip = request.page;

        var sql = "select * from getalerthistory($1,$2,$3,$4)";

        return util.executeDBQuery(sql,[request.where.personid,skip,limit,request.alertid])
          .then(withCount)
          .catch(err => util.logError(err));
            };

    Personalert.remoteMethod('updatealert', {
        http: {
                path: '/updatealert',
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

    Personalert.updatealert = function(request, reqctx) {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
     var status = request.status
    
     const securityusersid =_securityusersid; 
     if (status == 'Inactive') {
         LOGGER.debug("not undefined")
         var sql = "update personalert set status='Inactive', activeflag=0,enddatetime=$1,notes=$2,updatedby=$3 where personalertid=$4"
         
         return util.executeDBQuery(sql,[request.enddatetime,request.notes,securityusersid,request.personalertid])
        .then(res => {
            return res
        })
        .catch(err => {
            LOGGER.error(err)
        })
     } else {
            var securityuserid = _securityusersid;

           var alertid =request.alertid;
           LOGGER.debug("alertid"+request.alertid)
           if(alertid == undefined)
           {
           alertid = request.personalertid;
           var sqlq = "update personalert set alertid=$1,activeflag=0 WHERE  personalertid=$2 ";

			util.executeDBQuery(sqlq, [alertid,request.personalertid])
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
           } else {
            alertid = request.alertid;
           }
           
           let status1 = request.status
           if(status1 == undefined)
           {
            status1 = 'Active';
           }
           LOGGER.debug(request)
             Personalert.create({
                alerttype:request.alerttype,
                startdatetime:request.startdatetime,
                enddatetime:request.enddatetime,
                notes:request.notes,
                updatedby:securityuserid,
                personid:request.personid,
                alertid:alertid,
                status:status1
            })
            var sql1 = "update personalert set alertid=$1,activeflag=0 WHERE  personalertid=$2 "

            return util.executeDBQuery(sql1,[alertid,request.personalertid])
            .then(res => {
                return res
            })
            .catch(err => {
                LOGGER.error(err)
            })
     }
     
      
      
    };



   
        
    Personalert.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personalert.observe('access', (ctx, next) => util.access(ctx, next));
    Personalert.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
