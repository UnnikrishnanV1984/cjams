'use strict';
const LOGGER = require("log4js").getLogger("legalcustody");
const util = require('../utils/utils');
var app = require('../../server/server');
var config = require('../../server/config.json');
module.exports = function(Legalcustody) {   

  Legalcustody.addupdate = (request, reqctx) => {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    var legalcustodyid;
    if(request.legalcustodyid !== undefined && request.legalcustodyid !== null){
      legalcustodyid = request.legalcustodyid;
    }

    var sql = 'select * from validatelegalcustody($1,$2,$3,$4)';

    return util.executeDBQuery(sql,[request.permanencyplanid,legalcustodyid,request.fromdate,request.todate])
      .then(data => {
          if (request.legalcustodyid !== undefined && request.legalcustodyid !== null) {
            return Legalcustody.legalupdate(request, _securityusersid);
          } else {
            return Legalcustody.legaladd(request, _securityusersid);
          }
      })
      .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
      });
  }

  Legalcustody.deletelegalcustody = (request, reqctx) => {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    const sql = 'select * from deletelegalcustody($1, $2)';
    return util.executeDBQuery(sql, [request.legalcustodyid,  (request && request.securityuserid?request.securityuserid: _securityusersid)])
        .then(data => data)
        .catch(err => util.logError(err));
  };

  Legalcustody.remoteMethod('deletelegalcustody', {
    http: {
        path: '/deletelegalcustody',
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

  Legalcustody.legaladd = function (request, _securityusersid) {

    return Legalcustody.create({
      intakeserviceid: request.intakeserviceid,
      servicecaseid: request.servicecaseid,
      permanencyplanid: request.permanencyplanid,
      intakeservicerequestactorid: request.intakeservicerequestactorid,
      legalcustodytypekey: request.legalcustodytypekey,
       personid  : request.personid,
      reason: request.reason,
      fromdate: request.fromdate,
      todate: request.todate,
      insertedby: (request && request.securityuserid?request.securityuserid: _securityusersid),
      updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid) 
    }).then(data => {

      return data;
    })
      .catch(err => util.logError(err));
  }

  Legalcustody.legalupdate = (request, _securityusersid) => {

    return Legalcustody.updateAll(
      { legalcustodyid: request.legalcustodyid },
      {
        intakeserviceid: request.intakeserviceid,
        servicecaseid: request.servicecaseid,
        permanencyplanid: request.permanencyplanid,
        intakeservicerequestactorid: request.intakeservicerequestactorid,
        legalcustodytypekey: request.legalcustodytypekey,
        personid  : request.personid,
        reason: request.reason,
        fromdate: request.fromdate,
        todate: request.todate,
        updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid)
      }).then(data => {
        return "Legal updated successfully";
      }).catch(err => util.logError(err));

  }

    Legalcustody.remoteMethod('addupdate', {
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

   Legalcustody.getlegalcustody = function (request) {

        var sql = 'select * from getlegalcustody($1,$2)';
        
        return util.executeSecondaryNodeDBQuery(sql, [request.where.personid,request?.where?.isExpungementSuperUser])
          .then(data => data)
          .catch(err => {
             LOGGER.error('>>>>ERROR:', err);
              return util.logError(err);
          });
      
      };
      
      Legalcustody.remoteMethod('getlegalcustody', {
        accepts: {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        },
        http: {
          path: '/getlegalcustody',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });
    

      Legalcustody.remoteMethod('getlegalcustodymultiple', {
        accepts: {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        },
        http: {
          path: '/getlegalcustodymultiple',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });

      Legalcustody.getlegalcustodymultiple = function (request) {

        var sql = 'select * from getlegalcustodymultiplepersons($1)';
        var params = [request.where.personid];

        return util.executeDBQuery(sql, params)
          .then(data => {
              return data;
          })
          .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });

      };

    Legalcustody.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Legalcustody.observe('access', (ctx, next) => util.access(ctx, next));
    Legalcustody.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
