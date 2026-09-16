'use strict';
const LOGGER = require("log4js").getLogger("providerinfo");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Providerinfo) {
    Providerinfo.remoteMethod('getproviderinfo', {
        accepts : {
          arg : 'filter',
          type : 'Object',
          http : {
            source : 'query'
          },
          required : true
        },
        http : {
          path: '/getproviderinfo',
          verb : 'get'
        },
        returns : {
          type : 'string',
          root : true
        }
      });
    
      Providerinfo.getproviderinfo = data => {

        var provider_id = data.where.provider_id;
        var sql = '';

        sql = 'select * from listproviderinfo($1)';

        const params = [provider_id];

        return util.executeDBQuery(sql, params)
          .then(data2 => data2)
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

      };


      Providerinfo.remoteMethod('financeproviderreport', {
        accepts : {
          arg : 'filter',
          type : 'Object',
          http : {
            source : 'query'
          },
          required : true
        },
        http : {
          path: '/financeproviderreport',
          verb : 'get'
        },
        returns : {
          type : 'string',
          root : true
        }
      });
    
      Providerinfo.financeproviderreport = data => {

        var provider_id = data.where.provider_id;
        var sql = '';

        sql = 'select * from financeproviderreport($1)';

        const params = [provider_id];

        return util.executeDBQuery(sql, params)
          .then(data1 => util.encryptresponse(data1))
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

      };

      Providerinfo.remoteMethod('addresshistorydetails', {
        accepts : {
          arg : 'filter',
          type : 'Object',
          http : {
            source : 'query'
          },
          required : true
        },
        http : {
          path: '/addresshistorydetails',
          verb : 'get'
        },
        returns : {
          type : 'string',
          root : true
        }
      });
    
      Providerinfo.addresshistorydetails = data => {

        var provider_id = data.where.provider_id;
        var sql = '';

        sql = 'select * from addresshistorydetails($1)';

        const params = [provider_id];

        return util.executeDBQuery(sql, params)
          .then(data4 => data4)
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

      };
    
    
    Providerinfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providerinfo.observe('access', (ctx, next) => util.access(ctx, next));
    Providerinfo.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
