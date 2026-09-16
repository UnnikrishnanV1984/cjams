'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Providerapprovetypeconfig) {

    

    Providerapprovetypeconfig.remoteMethod('details', {
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

	Providerapprovetypeconfig.details = (request) => {
        let providerid = '';  
         providerid = request.where.providerid;		
        const sql = 'select * from getpublicproviderhomedetails($1)';


		return util.executeDBQuery(sql, [providerid])
			.then(data => data)
			.catch(err => err);
	};

    Providerapprovetypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providerapprovetypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Providerapprovetypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
