'use strict';
const LOGGER = require("log4js").getLogger("form1080b");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Form1080b) {

  Form1080b.addupdate = function (request, reqctx) {
    let suserid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
      suserid = reqctx.req.headers.securityusersid
    }
    var sql = 'select * from addupdateform1080b($1::json,$2::character varying)';
    var userid = request && request.securityuserid ? request.securityuserid : suserid;
    return util.executeDBQuery(sql, [request, userid])
      .then(data => {
        if (data.length > 0) {
          return data[0];
        } else {
          return { message: 'Please try again later', code: 500 };
        }
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

  Form1080b.remoteMethod('addupdate', {
    accepts: [{
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'body'
      },
      required: true
    }, {
      arg: 'reqctx',
      type: 'object',
      http: {
        source: 'context' 
      }
    }]
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

  Form1080b.getForm1080b = (request, reqctx) => {
    const form1080bid = request.where.form1080bid;

    return Form1080b.find({
      where: {
        form1080bid: form1080bid
      },
    })
      .then(data1 => {
        return JSON.parse(JSON.stringify(data1[0]));
      })
      .catch(err => {
        LOGGER.error(err);
        return util.logError(err)
      });
  };
  
  Form1080b.remoteMethod('getForm1080b', {
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
    http: { verb: 'get', path: '/getForm1080b' },
    returns: {
      type: 'Object',
      root: true
    }
  });
  
  Form1080b.list = function (request, reqctx) {
    let sql = 'select * from getform1080b($1::jsonb)';
    const param = {
      objectid: request.where.objectid
    };
    return util.executeSecondaryNodeDBQuery(sql, [JSON.stringify(param)])
      .then(data => {
        let response = [];
        if(data && data[0] && data[0].getform1080b){
          response = data[0].getform1080b
        }
        return response;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        return util.logError(err);
      });
  };
  
  Form1080b.remoteMethod('list', {
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
  
  Form1080b.delete = (form1080bid, reqctx) => {
    let suserid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers) {
      suserid = reqctx.req.headers.securityusersid
    }
    var sql = 'select * from deleteform1080b($1::uuid, $2::character varying)';
    var params = [form1080bid, suserid];
    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Form1080b.remoteMethod('delete', {
    accepts:
      [{
        arg: 'form1080bid',
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
    http: { "verb": "delete", "path": "/delete/:form1080bid" },
    returns: {
      type: 'Object',
      root: true
    }
  });

}