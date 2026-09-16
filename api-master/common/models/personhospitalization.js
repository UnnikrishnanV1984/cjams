'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const { now } = require('moment');
const moment = require('moment');
const trylatermsg = 'Please try again later';
const LOGGER = require("log4js").getLogger("personhospitalization");
module.exports = function (Personhospitalization) {

  Personhospitalization.remoteMethod('addupdate', {
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

  Personhospitalization.addupdate = function (request, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    if (request.hospitalizationid == null || request.hospitalizationid == undefined) {
      request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
      request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
      return Personhospitalization.create(request)
        .then(res => res)
        .catch(err => util.logError(err));
    }
    else {
      request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
      return Personhospitalization.updateAll({ hospitalizationid: request.hospitalizationid }, request)
        .catch(err => util.logError(err));
    }
  };

  Personhospitalization.remoteMethod('list', {
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

  Personhospitalization.list = request => {
    var page = request.page;
    if (request.page !== 'undefined') {
      request.skip = (request.page - 1) * request.limit;
    }
    var limit = request.limit;
    var totalcount = 0;
    var sql = 'select * from gethospitalizationlistfilter($1,$2,$3)';

    return util.executeSecondaryNodeDBQuery(sql, [request.where, page,limit])
      .then(data => {
        if (data !== null && data.length > 0) {
          totalcount = data[0].totalcount;
        }
        var result;
        result = {
          'data': data,
          'count': totalcount
        };
        return result;
      })
      .catch(err => { 
        LOGGER.error('>>>>ERROR:', err);
        return util.logError(err);
      });
  }



  Personhospitalization.remoteMethod('notificationsupdate', {
    http: {
            path: '/notificationsupdate',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} ],
    returns: {
        type : 'Object',
        root : true
    }
});

Personhospitalization.notificationsupdate = request => {
    const sql = `update personhospitalization set notificationdate = now() , updatedby = $1, updatedon = now() where hospitalizationid = $2; `;

    return util.executeDBQuery(sql, [request.securityuserid, request.hospitaldetails[0].hospitalizationid])
    .then(result => {
        return {
            success: true,
            data: result
        };
    })
    .catch(err =>{
        LOGGER.error(err);
        return {
            message: trylatermsg,
            success: false
        };
    });
};


  Personhospitalization.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Personhospitalization.observe('access', (ctx, next) => util.access(ctx, next));
  Personhospitalization.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PHOS',
  (ctx.isNewInstance || (ctx.instance && ctx.instance.personid)) ? ctx.instance.personid : ctx.where.personid));
  Personhospitalization.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}