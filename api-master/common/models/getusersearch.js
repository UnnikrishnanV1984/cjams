'use strict';
const LOGGER = require("log4js").getLogger("getusersearch");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Getusersearch) {

	Getusersearch.getusersearch  =function(data){
		var newJsonStructure = data.where;
		newJsonStructure["PageNumber"] = data.page;
		newJsonStructure["PageSize"] = data.limit;
        var Totalcount = 0;

		const newJsonStructureData = JSON.stringify(newJsonStructure);
		var countPromise;
 if(data.page == 1){
	 var Count = 'select * from staffsearch_cnt($1)';
		countPromise = util.executeDBQuery(Count, [newJsonStructureData])
			.then(_data => {
				Totalcount = _data[0].staffsearch_cnt;
			});
	} else {
		countPromise = Promise.resolve();
	}

		var sql = 'select * from StaffSearch($1)';

		return countPromise
			.then(() => util.executeDBQuery(sql, [newJsonStructureData]))
			.then(_data => {
				return {
					'data' : _data,
					'count' : Totalcount
				};
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

	}
	Getusersearch.remoteMethod(
			'getusersearch', 
				    {
				      http: {
				      		path: '/getusersearch',
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

		Getusersearch.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Getusersearch.observe('access', (ctx, next) => util.access(ctx, next));
		Getusersearch.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
