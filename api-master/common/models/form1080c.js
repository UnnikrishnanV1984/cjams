'use strict';
const LOGGER = require("log4js").getLogger("form1080c");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Form1080c) {

    Form1080c.addupdate = function (request,reqctx) {
        let suserid = undefined;
          if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            suserid = reqctx.req.headers.securityusersid
          } 
        var sql = 'select * from cjams.addupdateform1080c($1::jsonb,$2::character varying)';
        var userid = request && request.securityuserid ? request.securityuserid : suserid;
        return util.executeDBQuery(sql, [request, userid])
          .then(data => {
            if(data.length > 0) {
              return data[0];
            } else {
              return {message: 'Please try again later', code: 500};
            }
          })
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      };
    

      Form1080c.remoteMethod('addupdate', {
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

    Form1080c.getForm1080c = (request, reqctx) => {
        const form1080cid = request.where.form1080cid;

        return Form1080c.find({
            where: {
                form1080cid: form1080cid
            },
        })
            .then(data1 => {
                if (!data1 || !data1[0]) {
                    throw new Error('No data found for Form 1080C');
                }
                return JSON.parse(JSON.stringify(data1[0]));
            })
            .catch(err => {
                LOGGER.error(err);
                return util.logError(err)
            });
    };

    Form1080c.remoteMethod('getForm1080c', {
        accepts: [
            {
                arg: 'filter',
                type: 'object',
                required: true,
                http: { source: 'query' }
            },
            {
                arg: 'reqctx',
                type: 'object',
                http: { source: 'context' }
            }
        ],
        http: { verb: 'get', path: '/getForm1080c' },
        returns: {
            type: 'Object',
            root: true
        }
    });

  Form1080c.list = function (request, reqctx) {

        let sql = 'select * from cjams.getform1080c($1::jsonb)';
        const param = {
            objectid: request?.where?.objectid ?? null
        };

        return util.executeSecondaryNodeDBQuery(sql, [JSON.stringify(param)])
            .then(datas => { return datas; })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                return util.logError(err);
            });

    };


    Form1080c.remoteMethod('list', {
        accepts: [
            {
                arg: 'filter',
                type: 'Object',
                http: { source: 'query' },
                required: true
            },
            {
                arg: 'reqctx',
                type: 'object',
                http: { source: 'context' }
            }
        ],
        http: {
            path: '/list',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Form1080c.delete = (form1080cid, reqctx) => {
        let suserid = undefined;
        if (reqctx && reqctx.req && reqctx.req.headers) {
            suserid = reqctx.req.headers.securityusersid
        }
        let sql = 'select * from cjams.deleteform1080c($1::uuid, $2::character varying)';
        var params = [form1080cid, suserid];
        return util.executeDBQuery(sql, params)
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    }

    Form1080c.remoteMethod('delete', {
        accepts:
            [{
                arg: 'form1080cid',
                type: 'string',
                required: true,
                http: { source: 'path' }
            },
            {
                arg: 'reqctx',
                type: 'object',
                http: { source: 'context' }
            }
            ],
        http: { "verb": "delete", "path": "/delete/:form1080cid" },
        returns: {
            type: 'Object',
            root: true
        }
    });

}