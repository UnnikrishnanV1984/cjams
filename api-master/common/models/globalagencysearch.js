'use strict';
const LOGGER = require("log4js").getLogger("globalagencysearch");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Globalagencysearch) {
Globalagencysearch.getAgencySearchData = function(data){
		var Totalcount = 0;
		var showCount = false;
		if(data.page === 1){
			showCount = true
		}
		var newJsonStructure = data.where;
		newJsonStructure["pagenumber"] = data.page;
		newJsonStructure["pagesize"] = data.limit;

		const newJsonStructureData = JSON.stringify(newJsonStructure);

		if(showCount){
			var countQuery = 'select * from provideragencysearch_cnt($1)';
			return util.executeDBQuery(countQuery,[newJsonStructureData])
			.then(data1 => {
				Totalcount = data1[0].provideragencysearch_cnt;
				if (Totalcount > 0) {
					var sql = 'select * from provideragencysearch($1)';
					return util.executeDBQuery(sql,[newJsonStructureData])
					.then(_data => {
						LOGGER.info(_data);
						var result;
						result = {
							'data': _data,
							'count': Totalcount
						};
						return result;
					});
				} else {
					var result1;
					result1 = {
						'data': [],
						'count': Totalcount
					};
					return result1;
				}
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
		} else {
			var sql1 = 'select * from provideragencysearch($1)';
			return util.executeDBQuery(sql1,[newJsonStructureData])
			.then(_data => {
				return {
					'data': _data
				};
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
		}
}

Globalagencysearch.remoteMethod(
				'getAgencySearchData', 
					    {
					      http: {
					      		path: '/getAgencySearchData',
					      		verb: 'post'
					      },
					     accepts : [ {arg : 'data',type : 'object',
					     		http : {source : 'body'}} ],   
					      returns: {
					    	  type : 'object',
								root : true
					      }
					     }
			);


Globalagencysearch.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Globalagencysearch.observe('access', (ctx, next) => util.access(ctx, next));
Globalagencysearch.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
