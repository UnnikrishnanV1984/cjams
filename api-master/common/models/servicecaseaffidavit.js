'use strict';
const LOGGER = require("log4js").getLogger("ServicecaseAffidavit");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (ServicecaseAffidavit) {
    
    ServicecaseAffidavit.addupdate = function (request,reqctx) {
      let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
      var sql = 'select * from addupdateservicecaseaffidavit($1::json,$2::uuid)';
      var userid = request && request.securityuserid?request.securityuserid: suserid;
      return util.executeDBQuery(sql, [request, userid])
        .then(data => {
          if(data.length > 0) {
            return data[0];
          } else {
            return {message: 'Please try again later', code: 500};
          }
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };
  
    ServicecaseAffidavit.remoteMethod('addupdate', {
      accepts: [{
        arg: 'filter',
        type: 'Object',
        http: {
          source: 'body'
        },
        required: true
      },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      } ]
,
      http: {
        path: '/addupdate',
        verb: 'post'
      },
      returns: {
        type: 'Object',
        root: true
      }
    });

    ServicecaseAffidavit.list = function (request) {
  
        var sql = ` select a.*, b.fullname as updatedbyname
                    from servicecaseaffidavit a
                    inner join userprofile b on a.updatedby = b.securityusersid
                    where a.objectid = $1 and a.activeflag = 1; `
        return util.executeDBQuery(sql, [request.where.objectid])
          .then(data => {
            return data;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
    };
  
    ServicecaseAffidavit.remoteMethod('list', {
      accepts: {
        arg: 'filter',
        type: 'Object',
        http: {
          source: 'body'
        },
        required: true
      },
      http: {
        path: '/list',
        verb: 'post'
      },
      returns: {
        type: 'Object',
        root: true
      }
    });

    ServicecaseAffidavit.remoteMethod('delete', {
      accepts:
       [ {
          arg: 'id',
          type: 'string',
          required: true,
          http: { source: 'path' }
        },
        { arg: 'reqctx',
        type: 'object',
         http: {source: 'context'} }
      ],
        http: { "verb": "delete", "path": "/delete/:id" },
        returns: {
          type: 'Object',
          root: true
        }
    });

    ServicecaseAffidavit.delete = (id,reqctx) => {
      let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
      var sql = ` UPDATE servicecaseaffidavit
                  SET activeflag=0, updatedby = $2, updatedon = now()
                  WHERE servicecaseaffidavitid= $1 `;
      var params = [id,suserid];

      return util.executeDBQuery(sql, params)
        .then(data => {
          return data;
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    }
    
  }