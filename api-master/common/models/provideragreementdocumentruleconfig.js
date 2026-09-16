'use strict';
const LOGGER = require("log4js").getLogger("provideragreementdocumentruleconfig");
const util = require('../utils/utils');

module.exports = function(provideragreementdocumentruleconfig) {

	var totalCount;
	provideragreementdocumentruleconfig.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return provideragreementdocumentruleconfig.find(request);

	};
	
	provideragreementdocumentruleconfig.getstatestatutesearch = function(data){
		LOGGER.debug('data--->' + data);
		LOGGER.debug('data.limit--->' + data.limit);
		LOGGER.debug('data.page--->' + data.page);
		LOGGER.debug('data.where--->' + data.where.name);
		var Totalcount = 0;

		var sql = 'select * from getstatestatute($1,$2,$3)'
		LOGGER.debug('11111'+sql)

		if(data.page == 1){
			LOGGER.debug('coming')
			 var Count = 'select * from getstatestatute_cnt($1)';

			 LOGGER.debug('2222'+Count)
			return util.executeDBQuery(Count, [data.where.name])
				.then(_data => {
					Totalcount = _data[0].getstatestatute_cnt;
					LOGGER.debug('3333--->'+Totalcount)
					return util.executeDBQuery(sql, [data.where.name,data.page,data.limit]);
				})
				.then(data1 => {
					return {
						'data' : data1,
						'count':Totalcount
					};
				})
				.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
		}

		return util.executeDBQuery(sql, [data.where.name,data.page,data.limit])
			.then(data2 => {
				return {
					'data' : data2,
					'count':Totalcount
				};
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}
	
	provideragreementdocumentruleconfig.docdelete = function(request){

		return provideragreementdocumentruleconfig.update({provideragreementdocumentruleconfigid: request.provideragreementdocumentruleconfigid}, {activeflag:0});

      	};

      	provideragreementdocumentruleconfig.deficiencydelete = function(request){

      		var sql = 'UPDATE provideragreementdocumentruleconfig SET statestatutesid=null  WHERE provideragreementdocumentruleconfigid =\''+request.provideragreementdocumentruleconfigid+'\'';

    		return util.executeDBQuery(sql, [])
    			.then(data => data)
    			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

        };

	

          	provideragreementdocumentruleconfig.beforeRemote('list', function(ctx, request, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			provideragreementdocumentruleconfig.count({
				archiveon : null
			}, function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

          	provideragreementdocumentruleconfig.afterRemote('list',
			function(ctx, resultset, next) {

				if (ctx.result) {
					ctx.result = {
						'data' : resultset,
						'count' : totalCount
					};
				}
				next();
			});

      	provideragreementdocumentruleconfig.remoteMethod('list', {
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
	
provideragreementdocumentruleconfig.remoteMethod(
			'getstatestatutesearch', 
				    {
				      http: {
						      		path: '/getstatestatutesearch/list',
						      		verb: 'get'
				     		 },
				      accepts : [ {
									arg : 'filter',
									type : 'object',
									required : true
								} ],   
				      returns: {
						      		root : true,
						      		type: 'object'
				      			}
				     }
		);
	
          	provideragreementdocumentruleconfig.remoteMethod(
			'docdelete', 
				    {
				      http: {
				      		path: '/delete',
				      		verb: 'post'
				      },
				     accepts : [ {
		arg : 'data',
		type : 'object',
		http : {
			source : 'body'
		}
	} ],   
				      returns: {
				      		arg: 'data', 
				      		type: 'object'
				      }
				     }
		);
          	provideragreementdocumentruleconfig.remoteMethod(
			'deficiencydelete', 
				    {
				      http: {
				      		path: '/deficiencydelete',
				      		verb: 'post'
				      },
				     accepts : [ {
		arg : 'data',
		type : 'object',
		http : {
			source : 'body'
		}
	} ],   
				      returns: {
				      		arg: 'data', 
				      		type: 'object'
				      }
				     }
		);
	
		
		provideragreementdocumentruleconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		provideragreementdocumentruleconfig.observe('access', (ctx, next) => util.access(ctx, next));
		provideragreementdocumentruleconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
