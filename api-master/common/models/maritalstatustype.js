'use strict';
const LOGGER = require("log4js").getLogger("maritalstatustype");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Maritalstatustype) {
	
	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
	var totalCount;
	Maritalstatustype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Maritalstatustype.find(request);

	};

	Maritalstatustype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Maritalstatustype.count(JSON.parse(ctx.req.query.filter).where,function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Maritalstatustype.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});

	Maritalstatustype.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

	Maritalstatustype.remoteMethod('getvalues', {
        http: {
            path: '/getvalues',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Maritalstatustype.getvalues = function(request){
        var sql = "select maritalstatustypekey,typedescription from maritalstatustype order by typedescription asc"
        return util.executeDBQuery(sql, [])
          .then(res =>{
            return res
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
        }
	
		
    Maritalstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Maritalstatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Maritalstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
