'use strict';
const LOGGER = require("log4js").getLogger("assessmenttemplatescoremapping");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Assessmenttemplatescoremapping) {
	
	
	
	Assessmenttemplatescoremapping.list = function(request) {

		var scoretypekey = undefined;
		if(request.where !== undefined){
			scoretypekey = request.where.assessmentscoretypekey;
		}

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;

		}

		var sql = 'select * from assessmentscoremapping($1,$2,$3)';
		LOGGER.debug('1111111111'+sql)
		return util.executeDBQuery(sql, [request.page,request.limit,scoretypekey])
			.then(records => {
	      				var data =[];

	      				var record ={
	      						data
	      				}

	      				var temp_map = new Map();


	      				for (var len = records.length, i = 0; i < len; ++i) {
	      				const key = records[i].assessmentscoretypekey
	      				if(temp_map.get(key) == undefined){

	      					const obj = {
	      							"name":records[i].name,
	      							"assessmenttemplateid":records[i].assessmenttemplateid,
	      							"scoringmethod":records[i].scoringmethod
	      					}

	      							const arr = [];
	      							arr.push(obj);
	      							temp_map.set(key,arr);
	      						} else {
	      							const arr = temp_map.get(key);
	      							const obj = {
	      									"name":records[i].name,
	      									"assessmenttemplateid":records[i].assessmenttemplateid,
	      									"scoringmethod":records[i].scoringmethod
	      							}
	      							arr[arr.length] = obj;
	      							temp_map.set(key,arr);
	      						}
	      				}
	      				for (var [_key, value] of temp_map) {
	      						var objAllegation = {
	      								"assessmentscoretypekey":_key,
	      								 "assessmenttemplate":value,

	      							};

	      						data.push(objAllegation);

	      					}
	      				return record;
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

		};
		
	Assessmenttemplatescoremapping.save = function (request) {

		LOGGER.debug('----->>>>>>>' + request.assessmentscoretypekey)
		var assessmenttemparray = request.assessmenttemplateid;

		var sql4 = 'select * from Assessmenttemplatescoremapping where assessmentscoretypekey= $1';

		util.executeDBQuery(sql4,[request.assessmentscoretypekey])
			.then(records => {

			if (records.length == 0) {
				LOGGER.debug('newrecord--->>>>>>>')

				if (Array.isArray(assessmenttemparray)) {

				return assessmenttemparray.map(element => {

						var tempid = element;
						LOGGER.debug("tempid--->" + tempid);

						var sql3 = 'INSERT INTO Assessmenttemplatescoremapping (assessmentscoretypekey,scoringmethod,assessmenttemplateid) VALUES ($1,$2,$3)';
						return util.executeDBQuery(sql3, [request.assessmentscoretypekey, request.scoringmethod, tempid])
							.then(data => {
								LOGGER.info(data);
								return data;
							})
							.catch(_err => {
								LOGGER.error(_err);
								throw _err;
							})
					});
				}
			} else if (records.length > 0) {
				LOGGER.debug('oldrecord--->>>>>>>')

				var sql1 = 'delete from Assessmenttemplatescoremapping where assessmentscoretypekey= $1';
				return util.executeDBQuery(sql1, [request.assessmentscoretypekey])
					.then(data => {
						if (Array.isArray(assessmenttemparray)) {

							return assessmenttemparray.map(element => {
								var tempid = element;
								LOGGER.debug("tempid--->" + tempid);

								var sql2 = 'INSERT INTO Assessmenttemplatescoremapping (assessmentscoretypekey,scoringmethod,assessmenttemplateid) VALUES ($1,$2,$3)';
								return util.executeDBQuery(sql2, [request.assessmentscoretypekey, request.scoringmethod, tempid])
									.then(_data => {
										LOGGER.info(_data);
										return _data;
									})
									.catch(_err => {
										LOGGER.error(_err);
										throw _err;
									})
							});
						}
					})
					.catch(_err => {
						LOGGER.error(_err);
						throw _err;
					})
			}

		})
		.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
		return Promise.resolve("Success");
	}
		

	Assessmenttemplatescoremapping.remoteMethod('list', {
		accepts: {
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'query'
			},
			required: true
		},
		http: {
			verb: 'get'
		},
		returns: {
			type: 'object',
			root: true
		}
	});
		
		Assessmenttemplatescoremapping.remoteMethod(
			'AssessmentList', {
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
				type : 'Object',
				root : true
			}
		});
		
		Assessmenttemplatescoremapping.remoteMethod(
				'save', 
					    {
					      http: {
					      		path: '/save',
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

			Assessmenttemplatescoremapping.observe('before save', (ctx, next) => util.beforesave(ctx, next));
			Assessmenttemplatescoremapping.observe('access', (ctx, next) => util.access(ctx, next));
			Assessmenttemplatescoremapping.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
		

};
