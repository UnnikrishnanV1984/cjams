'use strict';
const LOGGER = require("log4js").getLogger("personclearinginfo");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Personclearinginfo) {
Personclearinginfo.getpersonclearinginfodata = function(data){
		var Totalcount = 0;
		var showCount = false;
		if(data.page === 1){
			showCount = true;
		}/* else{showCount = false}; */				//SonarQube fix - commented as showCount is already set to false above
		var newJsonStructure = data.where;
		newJsonStructure["pagenumber"] = data.page;
		newJsonStructure["pagesize"] = data.limit;

		const newJsonStructureData = JSON.stringify(newJsonStructure);
		var sql = 'select * from personclearinginfo($1)';

		if(showCount){
			var countQuery = 'select * from personclearinginfo_cnt($1)';
			return util.executeDBQuery(countQuery, [newJsonStructureData]).then(_data => {
				Totalcount = _data[0].personclearinginfo_cnt;
				return util.executeDBQuery(sql, [newJsonStructureData]).then(data1 => {
					var result = {'data' : data1};
					result['count'] = Totalcount;
					return result;
				});
			}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
		}

		return util.executeDBQuery(sql, [newJsonStructureData]).then(data1 => {
			return {'data' : data1};
		}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

Personclearinginfo.remoteMethod(
				'getpersonclearinginfodata', 
					    {
					      http: {
					      		path: '/getpersonclearinginfodata',
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


			Personclearinginfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
			Personclearinginfo.observe('access', (ctx, next) => util.access(ctx, next));
			Personclearinginfo.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
