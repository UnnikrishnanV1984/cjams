'use strict';
const LOGGER = require("log4js").getLogger("allegation");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function (Allegation) {
	var totalCount;
	Allegation.getallegationsandindicaors = function (request) {
		var objArrResult = [];
		var sql = 'select * from getallegationsandindicaors($1)';
		LOGGER.debug('sql:: ' + sql);
		return util.executeDBQuery(sql, [request.where.intakeservreqtypeid])
			.then(data => {
				var temp_map = new Map();
				for (var len = data.length, i = 0; i < len; ++i) {
					const key = data[i].allegationname + "::" + data[i].allegationid;
					let arr = [];
					if (temp_map.get(key) === undefined) {
						arr = [];
						arr.push({
							indicatorid: data[i].indicatorid,
							indicatorname: data[i].allegationindicatorname
						 });
						temp_map.set(key, arr);
					} else {
						arr = temp_map.get(key);
						arr[arr.length] = {
						 	indicatorid: data[i].indicatorid,
						 	indicatorname: data[i].allegationindicatorname
						 };
						temp_map.set(key, arr);
					}
				}
				for (var [key1, value] of temp_map) {
					var arrKey = key1.split("::")
					var objAllegation = {
						"allegationname": arrKey[0],
						"allegationid": arrKey[1],
						"indicators": value
					};
					objArrResult.push(objAllegation);
				}
				return objArrResult;
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};

	Allegation.getallegationsindicators = request => {
		return Allegation.find({
			//fields:['allegationid', 'name'],
			nolimit:request.nolimit, limit:request.limit, skip:request.skip,
			where: {and: [
				{intakeservicereqtypeid: request.where.intakeservreqtypeid},
				{intakeservicereqsubtypeid: request.where.intakeserreqsubtypeid},
			]},
			order: 'name',
			include: {
				relation: 'indicator',
				scope: {
					fields: ['indicatorid', 'indicatorname'],
					nolimit:request.nolimit, limit:request.limit, skip:request.skip,
					order: 'indicatorname'
				}
			}
		})
		.then(data => data)
		.catch(err => util.logError(err));
	};

	Allegation.getcasesubtype = request => {
		let prs = [];
		let searchtype = '';
		if (request.where)
			{searchtype = request.where.type;}
		if (searchtype === 'AL') {
			const allegationids = request.where.allegationids;
			const intakeservicetypeid = request.where.intakeservicereqtypeid;
			if(allegationids.length === 0){
				 return  app.models.Servicerequestsubtype.find({
					where:{intakeservreqtypeid:intakeservicetypeid},
				 fields: ['intakeservreqtypeid', 'classkey', 'description','servicerequestsubtypeid']
					})

			}else{
				var sql = 'SELECT * FROM getcasesubtype($1,$2)';
				util.executeDBQuery(sql, [allegationids,intakeservicetypeid])
				.then((data)=>{
					LOGGER.info(data);
				}).catch(err=>{
					LOGGER.error(err);
				});
			}
		}
		else {
			const indicatorids = request.where.indicatorids;
			prs = indicatorids.map(indicatorid => {
				return app.models.Indicator.findOne({
				fields: ['indicatorid', 'allegationid'],
				where: {indicatorid: indicatorid},
				include: {
					relation: 'allegation',
					scope: {
						fields: ['allegationid', 'intakeservicereqsubtypeid'],
						include: {
							relation: 'servicerequestsubtype',
							scope: {
								fields: ['intakeservreqtypeid', 'classkey', 'description']
							}
						}
					}
				}
				})
			});
		}
		return Promise.all(prs)
		.then(result => {
			const data = JSON.parse(JSON.stringify(result));
			let daSubTypes = [];
			if(searchtype === 'AL')
				{daSubTypes = data.map(x => x.servicerequestsubtype);}

			else {
				daSubTypes = data.map(x => {
					if (x.allegation)
						{return x.allegation.servicerequestsubtype;}
				});
			}

			return daSubTypes.filter((thing, index, self) => self.findIndex(t => t.servicerequestsubtypeid === thing.servicerequestsubtypeid) === index);

		})
		.catch(err => util.logError(err));
	};


	Allegation.list = function (request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Allegation.find(request)
			.then(res => res)
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

	};

	Allegation.beforeRemote('list', function (ctx, request, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Allegation.count((JSON.parse(ctx.req.query.filter)).where, function (err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;
				LOGGER.debug(count);
			});

		}

		next();
	});

	Allegation.afterRemote('list',
		function (ctx, resultset, next) {

			if (ctx.result) {
				ctx.result = {
					'data': resultset,
					'count': totalCount
				};
			}
			next();
		});

	Allegation.remoteMethod('list', {
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
			type: 'string',
			root: true
		}
	});


	Allegation.remoteMethod('getallegationsandindicaors', {
		accepts: [{
			arg: 'filter',
			type: 'object',
			required: true
		}],
		http: {
			path: '/getallegationsandindicaors',
			verb: 'get'
		},
		returns: {
			type: 'Object',
			root: true
		}
	});

	Allegation.remoteMethod('getallegationsindicators', {
		accepts: [{
			arg: 'filter',
			type: 'object',
			required: true
		}],
		http: {
			path: '/getallegationsindicators',
			verb: 'get'
		},
		returns: {
			type: 'Object',
			root: true
		}
	});

	Allegation.remoteMethod('getcasesubtype', {
		accepts: [{
			arg: 'filter',
			type: 'object',
			required: true
		}],
		http: {
			path: '/getcasesubtype',
			verb: 'get'
		},
		returns: {
			type: 'Object',
			root: true
		}
	});

	Allegation.remoteMethod('allegationIndicatorsList', {
		accepts: [
			{
				arg: 'filter',
				type: 'object',
				required: true,
				http: { source: 'query' }
			}],
		http: { "verb": "get", "path": "/allegationIndicatorsList" },
		returns: {
			type: 'Object',
			root: true
		}
	});


	Allegation.allegationIndicatorsList = data => {
		const intakeservicereqtypeid = data.where.intakeservicereqtypeid;
		const intakeservicereqsubtypeid = data.where.intakeservicereqsubtypeid;

		return Allegation.find({
			where: {
				and: [{ activeflag: true },
				{ intakeservicereqtypeid: intakeservicereqtypeid },
				{ intakeservicereqsubtypeid: intakeservicereqsubtypeid }
				]
			},
			fields: ['allegationid', 'name'],
			order: 'name',
			include: {
				relation: 'indicator',
				scope: {
					where: { activeflag: true },
					fields: ['indicatorid', 'indicatorname'],
					order: 'indicatorname'
				}
			}
		})
		.then(data1 => {
			const allegations = JSON.parse(JSON.stringify(data1));
			allegations.forEach(allegation => {
				allegation.allegationname = allegation.name;
				allegation.indicators = allegation.indicator;
				delete allegation.name;
				allegation.indicators = allegation.indicator.map(indicator => indicator.indicatorname);
				delete allegation.indicator;
			})
			return allegations;
		})
		.catch(err => util.logError(err));
	};

	Allegation.remoteMethod('allegationWOIndicatorsList', {
		accepts: [
			{
				arg: 'filter',
				type: 'object',
				required: true,
				http: { source: 'query' }
			}],
		http: { "verb": "get", "path": "/allegationWOIndicatorsList" },
		returns: {
			type: 'Object',
			root: true
		}
	});

	Allegation.allegationWOIndicatorsList = data => {
		const intakeservicereqtypeid = data.where.intakeservicereqtypeid;
		const intakeservicereqsubtypeid = data.where.intakeservicereqsubtypeid;

		return Allegation.find({
			where: {
				and: [{ activeflag: true },
				{ intakeservicereqtypeid: intakeservicereqtypeid },
				{ intakeservicereqsubtypeid: intakeservicereqsubtypeid }
				]
			},
			fields: ['allegationid', 'name','isenablesextraffic'],
			order: 'name'
		})
			.then(data1 => data1)
			.catch(err => util.logError(err));
	};

	Allegation.remoteMethod('indicatorsList', {
		accepts: [
			{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
			{
				arg: 'filter',
				type: 'object',
				required: true,
				http: { source: 'query' }
			}],
		http: { "verb": "get", "path": "/indicatorsList/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});

	Allegation.indicatorsList = (id, data) => {
		const allegationid = id;

		const indiskip = (data.page - 1) * data.limit;
		const indilimit = data.limit;

		const prs = [];

		prs.push(app.models.Indicator.find({
			where: {
				and: [{ activeflag: true }, { allegationid: allegationid }]
			},
			fields: ['indicatorid', 'indicatorname'],
			order: 'indicatorname',
			skip: indiskip,
			limit: indilimit
		}));
		if (data.page === 1) {
			prs.push(app.models.Indicator.count({
				and: [{ activeflag: true }, { allegationid: allegationid }]
			}));
		}
		return Promise.all(prs)
			.then(data1 => {
				if (data1.length === 1)
					{return data1[0];}
				else if (data1.length === 2)
					{return {
						data: data1[0],
						count: data1[1]
					}}
			})
			.catch(err => util.logError(err));
	};

	Allegation.remoteMethod('updateAllegation', {
		accepts: [
			{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
			{
				arg: 'data',
				type: 'object',
				http: { source: 'body' }
			}],
		http: { "verb": "patch", "path": "/updateAllegation/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});

	Allegation.updateAllegation = (id, request) => {
		const allegationdata = request;
		let gAllegation;
		return Allegation.updateAll({allegationid: id}, allegationdata)
			.then(allegation => {
				gAllegation = allegation;
				allegationdata.indicator.forEach(x => x.allegationid = id);
				return Allegation.updateIndicators(allegationdata.indicator);
			})
			.then(indicators => {
				return {
					allegation: gAllegation,
					//indicators: indicators
				};
			})
			.catch(err => err);
	};

	Allegation.remoteMethod('addIndicators', {
		accepts: [
			{
				arg: 'data',
				type: 'object',
				http: { source: 'body' }
			}],
		http: { "verb": "post", "path": "/addIndicators" },
		returns: {
			type: 'Object',
			root: true
		}
	});

	Allegation.addIndicators = request => {
		const indicators = request.data;
		return Allegation.updateIndicators(indicators);
	};

	Allegation.updateIndicators = indicators => {
		let allegationid = '';
		if (indicators.length > 0)
			{allegationid = indicators[0].allegationid;}

		const prs = [];
		if (allegationid !== '')
			{prs.push(app.models.Indicator.updateAll({ allegationid: allegationid }, { activeflag: 0 }));}

		prs.push(indicators.filter(x => x.indicatorid).map(indicator => app.models.Indicator.updateAll({ indicatorid: indicator.indicatorid }, { activeflag: 1 })));

		prs.push(indicators.filter(x => !x.indicatorid).map(indicator => app.models.Indicator.create(indicator)))
		var flatPrs = prs.reduce((a, b) => a.concat(b), []);
		return Promise.all(flatPrs)
			.then(data => data)
			.catch(err => err);
	};

	Allegation.remoteMethod('addAllegation', {
		accepts: [
			{
				arg: 'data',
				type: 'object',
				http: { source: 'body' }
			}],
		http: { "verb": "post", "path": "/addAllegation" },
		returns: {
			type: 'Object',
			root: true
		}
	});

	Allegation.addAllegation = request => {
		const allegationdata = request;
		let gAllegation;
		return Allegation.create(allegationdata)
			.then(allegation => {
				gAllegation = allegation;
				allegationdata.indicator.forEach(x => x.allegationid = allegation.allegationid);
				return Promise.all(allegationdata.indicator.map(indicator => {
					return app.models.Indicator.create(indicator);
				}));
			})
			.then(indicators => {
				return gAllegation;
			})
			.catch(err => err);
	};

	Allegation.remoteMethod('getAllegation', {
		accepts: [{
			arg: 'id',
			type: 'string',
			required: true,
			http: { source: 'path' }
		},
		{
			arg: 'filter',
			type: 'object',
			required: true,
			http: { source: 'query' }
		}],
		http: { "verb": "get", "path": "/getAllegation/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});

	Allegation.getAllegation = (id, data) => {
		const indiskip = (data.page - 1) * data.limit;
		const indilimit = data.limit;
		return Allegation.find({
			where: {
				and: [
					{ activeflag: true },
					{ allegationid: id }
				]
			},
			include: {
				relation: 'indicator',
				scope: {
					where: { activeflag: true },
					fields: ['indicatorid', 'indicatorname'],
					order: 'indicatorname',
					skip: indiskip,
					limit: indilimit
				}
			}
		})
			.then(data1 => data1)
			.catch(err => util.logError(err));
	};



	Allegation.edit =(id) =>{

		return Allegation.find({
			where :{allegationid:id},
			include:{
				relation:"allegationstatestatutes",
				scope:{
					fields: ['statestatuteid'],
					include:{
						relation:"statestatutes",
						scope:{
							fields:['statestatuteskey','description']
						}
					}

				}
			}

		}).then(data=>{
			var tempdata = JSON.stringify(data)
			 return JSON.parse(tempdata)[0].allegationstatestatutes;
		})

	}

	Allegation.remoteMethod('edit',
	{
	  http: {
			  path: '/edit/:id',
			  verb: 'get'
	  },
	 accepts : {
		 arg : 'id',
		 type : 'string',
		 required: true,
		 http : {source : 'path'}
		},
	  returns: {
		  type : 'object',
			root : true
	  }
	 }
);
Allegation.remoteMethod('getoffenselist', {
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
		type: 'string',
		root: true
	}
});

Allegation.getoffenselist =(request)=>{

	var intakeserviceid = request.where.intakeserviceid;

	var sql = 'SELECT * FROM getoffense($1)';

	return util.executeDBQuery(sql, [intakeserviceid])
		.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}



	Allegation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Allegation.observe('access', (ctx, next) => util.access(ctx, next));
	Allegation.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
