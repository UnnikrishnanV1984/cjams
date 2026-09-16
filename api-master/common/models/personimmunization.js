'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');
var uuid = require('node-uuid');

module.exports = function(Personimmunization) {
    
    Personimmunization.list = function(request) {
        let personid = '';

        if(request.where && request.where.personid){
            personid = request.where.personid;
        }

        return Personimmunization.find({
            where: {personid: personid},
            fields: ['personimmunizationid', 'immunizationdocpath', 'reportedby', 'isimmunefileavail', 'insertedon']
        })
        .then(data => {
            return JSON.parse(JSON.stringify(data));
        })
        .catch(err => util.logError(err));
    };

    Personimmunization.remoteMethod('list', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            verb : 'get'
        },
        returns : {
            type : 'string',
            root : true
        }
    });

    
    Personimmunization.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        if(request.personimmunizationid== null || request.personimmunizationid == undefined)
        {
            request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);

            return Personimmunization.create(request)
            .then(res =>res)
            .catch(err => util.logError(err));
        }
        else
        {
          request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);   

          return Personimmunization.updateAll({personimmunizationid:request.personimmunizationid},request)
          .catch(err => util.logError(err));
        }
    };

    Personimmunization.remoteMethod('addupdate', {
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


    Personimmunization.remoteMethod('getpersonimmunization', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    
    Personimmunization.getpersonimmunization = request =>{

        var pageno = request.page;
        var pagesize = request.limit;

        const sql = 'select * from getpersonimmunization($1, $2, $3)';
        return util.executeDBQuery(sql, [request.where.personid, pageno, pagesize])
           .then(data => data[0].getpersonimmunization)
           .catch(err => err);
    }

    Personimmunization.remoteMethod('getimmunizationlist', {
        accepts: [{
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Personimmunization.getimmunizationlist=(request, reqctx)=>{
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const pageno = request.page;
        const pagesize = request.limit;
        request.where.current_user = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var totalcount = 0;
        var sql= 'select * from getpersonimmunizationlist($1,$2,$3)';
        return util.executeDBQuery(sql,[request.where.personid, pageno, pagesize])
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

    Personimmunization.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personimmunization.observe('access', (ctx, next) => util.access(ctx, next));
    Personimmunization.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PIMM',
    (ctx.isNewInstance || (ctx.instance && ctx.instance.personid)) ? ctx.instance.personid : ctx.where.personid));
    Personimmunization.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
