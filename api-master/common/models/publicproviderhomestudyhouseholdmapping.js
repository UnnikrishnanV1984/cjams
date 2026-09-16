'use strict';
const LOGGER = require("log4js").getLogger("publicproviderhomestudyhouseholdmapping");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
var config = require('../../server/config.json');
var email = require('./email');

module.exports = function (Publicproviderhomestudyhouseholdmapping) {

     Publicproviderhomestudyhouseholdmapping.gethomestudyhousehold  =function(request){
        var objId = request.where.object_id;

       var sql='select * from getproviderhomevisitlist($1)';
        return util.executeDBQuery(sql, [objId])
          .then(data => {
            return data;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
      };
    
      Publicproviderhomestudyhouseholdmapping.remoteMethod(
        'gethomestudyhousehold', 
        {
          accepts : {
            arg : 'data',
            type : 'object',
            http : {
              source : 'body'
            },
          },
          http: {
            path: '/gethomestudyhousehold',
            verb: 'POST'
          },
          returns : {
            type : 'object',
            root : true
          }
        }
        );

  Publicproviderhomestudyhouseholdmapping.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Publicproviderhomestudyhouseholdmapping.observe('access', (ctx, next) => util.access(ctx, next));
  Publicproviderhomestudyhouseholdmapping.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};