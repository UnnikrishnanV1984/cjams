'use strict';
const LOGGER = require("log4js").getLogger("serviceintendedaction");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Serviceintendedaction) {
    
  Serviceintendedaction.addupdate = function (request,reqctx) {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
      var sql = 'select * from addupdateserviceintendedaction($1::json,$2::uuid)';
      var userid = request && request.securityuserid?request.securityuserid:suserid;
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
  
    Serviceintendedaction.remoteMethod('addupdate', {
      accepts:[ {
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
      }],
      http: {
        path: '/addupdate',
        verb: 'post'
      },
      returns: {
        type: 'Object',
        root: true
      }
    });

    Serviceintendedaction.list = function (request) {
        var sql = ` select a.* ,
                    concat(p.firstname,' ', p.lastname) as caregivername,
                    b.fullname as updatedbyname
                    from serviceintendedaction a
                    inner join userprofile b on a.updatedby = b.securityusersid
                    left join person p on p.personid =  a.caregiverid and p.activeflag = 1
                    where a.objectid = $1 and a.activeflag = 1; `
        return util.executeDBQuery(sql, [request.where.objectid])
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
    };
  
    Serviceintendedaction.remoteMethod('list', {
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

    Serviceintendedaction.remoteMethod('delete', {
      accepts:
       [ {
          arg: 'id',
          type: 'string',
          required: true,
          http: { source: 'path' }
        }, {
          arg: 'reqctx',
          type: 'object',
           http: {source: 'context'}
          }
      ],

        http: { "verb": "delete", "path": "/delete/:id" },
        returns: {
          type: 'Object',
          root: true
        }
    });

    Serviceintendedaction.delete = (id,reqctx) => {
      let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
      var sql = ` UPDATE serviceintendedaction
                  SET activeflag=0, updatedby = $2, updatedon = now()
                  WHERE serviceintendedactionid= $1 `;

      return util.executeDBQuery(sql, [id, suserid])
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    }
    
  }