'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_picklist_values) {

  Tb_picklist_values.remoteMethod('getpicklist', {
    accepts: {
  arg: 'filter',
  type: 'Object',
  http: {
    source: 'query',
  },
  required: true,
},
  http: {
        verb: 'get',
    },
    returns: {
        type: 'Object',
        root: true,
    },
});

   Tb_picklist_values.getpicklist = request => {
        const picklist_type_id = request.where.picklist_type_id;
        const sql = 'select * from getpicklist($1)';
        return util.executeSecondaryNodeDBQuery(sql,[picklist_type_id])
        .then(data => {
            return util.encryptresponse(data);
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };
  Tb_picklist_values.remoteMethod('getexitreasonlist', {
      accepts: {
    arg: 'filter',
    type: 'Object',
    http: {
      source: 'query',
    },
    required: true,
  },
    http: {
          verb: 'get',
      },
      returns: {
          type: 'Object',
          root: true,
      },
  });

  Tb_picklist_values.getexitreasonlist = request => {
      const picklist_value_cd = request.where.picklist_value_cd;
      const sql = 'select * from getexitreasonlist($1)';
      return util.executeSecondaryNodeDBQuery(sql,[picklist_value_cd])
      .then(data => {
          return data;
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  };

  
Tb_picklist_values.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Tb_picklist_values.observe('access', (ctx, next) => util.access(ctx, next));
Tb_picklist_values.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}