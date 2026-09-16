'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestgroupdetails");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestgroupdetails) {
	
	Intakeservicerequestgroupdetails.getgrouphistory = function(data) {

		var Totalcount = 0;
		return Promise.resolve()
		.then(() => {
			if( data.page == 1) {
				var Count = 'select * from grouphistorybysridorgroupnumber_cnt($1,$2)';
				return util.executeDBQuery(Count, [data.where.intakeserviceid,data.where.groupnumber])
					.then(_data => {
						Totalcount = _data[0].grouphistorybysridorgroupnumber_cnt;
					});
			}
		})
		.then(() => {
			var sql = 'select * from grouphistorybysridorgroupnumber($1,$2,$3,$4)';
			return util.executeDBQuery(sql, [data.where.intakeserviceid,data.where.groupnumber,data.page,data.limit])
				.then(data1 => {
					return {
						'data' : data1,
						'count' : Totalcount
					};
				});
		})
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
	}
	Intakeservicerequestgroupdetails.remoteMethod('getgrouphistory', 
						    {
						      http: {
						      		path: '/getgrouphistory',
						      		verb: 'get'
						      },
						     accepts : [ {arg : 'data',type : 'object',
						     		http : {source : 'query'}} ],   
						      returns: {
						    	  type : 'object',
									root : true
						      }
						     }
				);


		Intakeservicerequestgroupdetails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Intakeservicerequestgroupdetails.observe('access', (ctx, next) => util.access(ctx, next));
		Intakeservicerequestgroupdetails.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
