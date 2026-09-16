'use strict';
const LOGGER = require("log4js").getLogger("progressnotetype");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Progressnotetype) {

	
	var listCount;
	
	Progressnotetype.listprognotetypes = function() {
		const teamtypekey = server.currentUser.teamtypekey;
		var ProgNoteClassifyTypeKey = 'user';
		var sql = 'select * from listprognotetypes($1,$2)';
		LOGGER.debug('sql:: ' + sql);
		return util.executeSecondaryNodeDBQuery(sql, [ProgNoteClassifyTypeKey,teamtypekey])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Progressnotetype.listprognotesubtypes = function(prognotetypeid) {
		const teamtypekey = 'CW';
		var sql = 'select * from listprognotesubtypes($1,$2)';
		var params = [prognotetypeid,teamtypekey];
		LOGGER.debug('sql:: ' +sql);
		return util.executeDBQuery(sql, params)
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};


	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */

	Progressnotetype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Progressnotetype.find(request);

	};

	Progressnotetype.beforeRemote('list', function(ctx, data, next) {

		LOGGER.debug(" - Start Remote Method Progressnotetype -");
		
		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			
	    LOGGER.debug(" - Process -");
			
		Progressnotetype.count(null,function(err, count) {

			if (err) {
				LOGGER.debug("Progressnotetype - Error in beforeRemote : "+err);
				throw err;
			}
			listCount = count;

		});
		
		}
		
		LOGGER.debug(" - End Remote Method Progressnotetype -"+listCount);

		next();
	});

	Progressnotetype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : listCount
			};
		}
		next();
	});
	
	Progressnotetype.remoteMethod('list', {
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
	
	Progressnotetype.remoteMethod ('listprognotetypes', {
      		http: {
      			path: '/listprognotetypes',
      			verb: 'get'
      		},
      		returns: {
      			type: 'Object',
      			root : true
      		}
     });

	Progressnotetype.remoteMethod ('listprognotesubtypes', {
      		http: {
      			path: '/listprognotesubtypes',
      			verb: 'get'
      		},
      		accepts: {
      			arg: 'prognotetypeid', 
      			type: 'string'
      		},
      		returns: {
      			type: 'Object',
      			root : true
      		}
     });
	 
	 Progressnotetype.deletesubtype = id => {
       
		return Progressnotetype.updateAll({progressnotetypeid: id}, {activeflag: 0})
		.catch(err => err);
		
	}
	
	
	Progressnotetype.remoteMethod(
        'deletesubtype', 
            {
                http: {
                        path: '/deletesubtype/:id',
                        verb: 'delete'
                },
                accepts : [ {
                arg: 'id',
                type: 'string',
                required: true,
                http: {source: 'path'}
            } ],   
                        
            returns: {
                type : 'object',
                root : true
            }
            
	});
		
	 Progressnotetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	 Progressnotetype.observe('access', (ctx, next) => util.access(ctx, next));
	 Progressnotetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
