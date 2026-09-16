'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Caseclosureparticipant) {

  Caseclosureparticipant.getcaseclosurelist =(request)=>{
            var sql = 'select * from getcaseclosurelist($1)';
            return util.executeSecondaryNodeDBQuery(sql,[request.where.intakeserviceid]).then((data)=>{
                return data[0].getcaseclosurelist;
            }).catch((err)=>{ LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
    }




           Caseclosureparticipant.remoteMethod('getcaseclosurelist', {
        accepts : {
          arg : 'filter',
          type : 'Object',
          http : {
            source : 'query'
          },
          required : true
        },
        http : {
                path: '/getcaseclosurelist',
          verb : 'get'
        },
        returns : {
          type : 'string',
          root : true
        }
        });

	Caseclosureparticipant.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Caseclosureparticipant.observe('access', (ctx, next) => util.access(ctx, next));
	Caseclosureparticipant.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};

