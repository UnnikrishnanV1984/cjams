'use strict';
const LOGGER = require("log4js").getLogger("helpdocuments");
const util = require('../utils/utils');
var app = require('../../server/server');
var fs = require('fs');

module.exports = function(helpdocuments) {
	let totalCount;
	helpdocuments.remoteMethod('list', {
        accepts : {arg: 'filter',type: 'Object',http: {source: 'query'},
        required : true},
        description: "helpdocuments List",
        notes: "helpdocuments list",
        http: {"verb": "get", "path": "/list"},
        returns : {type : 'Object',root : true}
    });


    helpdocuments.list = (arg) => {         
        arg.skip = (arg.page-1) * arg.limit;
        return helpdocuments.find(arg)
        .then(helpdocument => helpdocument)
        .catch(err => LOGGER.debug(err,' ERROR LIST helpdocuments'));
    };


    helpdocuments.beforeRemote('list', function(ctx, request, next) {
      if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
        const whereObj = JSON.parse(ctx.req.query.filter).where;
           helpdocuments.count(whereObj, function(err, count) {

            if (err){ throw err;    }
            totalCount = count;
           });
      }
      next();
    });

    helpdocuments.afterRemote('list',
       function(ctx, resultset, next) {
        if (ctx.result) {
         ctx.result = {
          'data' : resultset,
          'count' : totalCount
         };
        }
        next();
    });

    helpdocuments.remoteMethod('save', {
      http: {
          path: '/save',
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


helpdocuments.remoteMethod('delete', {
    http: {
        path: '/delete/:id',
        verb: 'delete'
    }, 
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} ],
    returns: {
        type : 'string',
        root : true
    }
});

helpdocuments.remoteMethod('helpdocuments', {
  accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
          source: 'query'
      },
      required: true
  },
  http: {
      path: '/helpdocuments',
      verb: 'get'
  },
  returns: {
      type: 'Object',
      root: true
  }
});
helpdocuments.helpdocuments = function (request) {

  var sql = 'select * from helpdocuments';
  return util.executeDBQuery(sql, [])
    .then(data => data)
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });

};

helpdocuments.delete = (id) => {
    var sql = 'update helpdocuments set activeflag = 0 WHERE helpdocumentsid =\''+id+'\'';
    return util.executeDBQuery(sql, [])
      .then(data => data)
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
};

   helpdocuments.save = function(request, reqctx)   {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
           const securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
             if(request.type === "save") {
            return helpdocuments.create({ 
                filename:request.filename ,
                title:request.title,
                category:request.category,
                subcategory:request.subcategory,
                insertedby: (request && request.securityuserid ? request.securityuserid : securityusersid),
                updatedby: (request && request.securityuserid ? request.securityuserid : securityusersid)
                })
                }else if(request.type === "update") {
            return helpdocuments.update({helpdocumentsid:request.helpdocumentsid},{
                filename:request.filename ,
                title:request.title,
                category:request.category,
                subcategory:request.subcategory,
                updatedby: (request && request.securityuserid ? request.securityuserid : securityusersid)
              })
            }
        return Promise.resolve('Invalid request');
    }

    helpdocuments.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    helpdocuments.observe('access', (ctx, next) => util.access(ctx, next));
    helpdocuments.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
