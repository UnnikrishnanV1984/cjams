'use strict';
const LOGGER = require("log4js").getLogger("providerinfoconfig");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Providerinfoconfig) {




    Providerinfoconfig.remoteMethod('list', {
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


    Providerinfoconfig.list = request => {
        let providerid = '';       
        providerid = request.where.providerid;      
        const sql = 'select * from providerhomeapprovelist($1)';
        return util.executeDBQuery(sql, [providerid])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      };


    Providerinfoconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providerinfoconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Providerinfoconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
