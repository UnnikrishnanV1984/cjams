'use strict';
const LOGGER = require("log4js").getLogger("tb_provider_address");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Tb_provider_address) {


  Tb_provider_address.remoteMethod('getformattedaddress', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      path: '/getformattedaddress',
      verb: 'get'
    },
    returns: {
      type: 'string',
      root: true
    }
  });

  Tb_provider_address.getformattedaddress = (request) => {

    var sql = 'select * from prov_get_formatted_addresses($1)';
    const params = [request.where.provider_id];

    return util.executeDBQuery(sql, params)
      .then(data => data)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };




  Tb_provider_address.remoteMethod('addupdate', {
    http: {
      path: '/addupdate',
      verb: 'post'
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
    },{
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
      }],
    returns: {
      type: 'string',
      root: true
    }
  });

  Tb_provider_address.delete_address = (request) => {
    return Tb_provider_address.updateAll({ address_id: request.address_id }, {
      delete_sw : 'Y',
      update_ts : request.update_ts,
      update_user_id : request.update_user_id,
      })
  }

  Tb_provider_address.addupdate = (request, reqctx) => {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    var create_user_id = suserid;
    request.update_user_id = create_user_id;
    request.update_ts = new Date().toLocaleString();
    if (!request.address_id) {
      request.create_ts = new Date().toLocaleString();
      request.create_user_id = create_user_id;
      return Tb_provider_address.create(request);
    } else {
      request.delete_sw='N';      
      return Tb_provider_address.updateAll({ address_id: request.address_id },  request);
    }
  }

  Tb_provider_address.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Tb_provider_address.observe('access', (ctx, next) => util.access(ctx, next));
  Tb_provider_address.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
