'use strict';
const LOGGER = require("log4js").getLogger("withhold_eft_config");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
var config = require('../../server/config.json');


module.exports = function (Withhold_eft_config) {

    Withhold_eft_config.remoteMethod('getwithholdchangelog', {
        accepts : {
          arg : 'filter',
          type : 'Object',
          http : {
            source : 'query'
          },
          required : true
        },
        http : {
          path: '/getwithholdchangelog',
          verb : 'get'
        },
        returns : {
          type : 'string',
          root : true
        }
      });
    
      Withhold_eft_config.getwithholdchangelog = data => {

        var provider_id = data.where.provider_id;
        var sql = '';

        if (data.page !== 'undefined') {
			data.skip = (data.page - 1) * data.limit;
		}

        sql = 'select wc.withholdeftconfigid,wc.withhold_payment_sw,wc.eft_sw,wc.activeflag,wc.provider_id,wc.withhold_reason,wc.withhold_question,up.fullname,wc.insertedon,(select ct.countyname from county ct where trim(ct.statecountycode) = up.primarycountycd ) as local_dept from withhold_eft_config wc  left join userprofile up on up.securityusersid = wc.insertedby where wc.provider_id=$1  order by wc.insertedon desc limit $2 offset $3';

        const params = [provider_id,data.limit,data.skip];

        return util.executeDBQuery(sql, params)
          .then(data2 => data2)
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

      };
  
    
  
    Withhold_eft_config.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Withhold_eft_config.observe('access', (ctx, next) => util.access(ctx, next));
    Withhold_eft_config.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};