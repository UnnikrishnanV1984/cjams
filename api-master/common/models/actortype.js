'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
const LOGGER = require("log4js").getLogger("actortype");

module.exports = function(Actortype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
    var totalCount;
	
	// NOSONAR
	// Actortype.list = function(request, cb) {
	// 	if (request.page !== 'undefined') {
	// 		request.skip = (request.page - 1) * request.limit;
	// 	}
	// 	Actortype.find(request, function(err, res) {
	// 		cb(err, res);
	// 	});
	// };

	Actortype.list = request => {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
		
		return Actortype.find({
			where: request.where,
			skip: request.skip,
			limit: request.limit,
			order: request.order,
			include: {
				relation: 'actortypeagency',
				scope: {
					fields: ['teamtypekey'],
					include: {
						relation: 'teamtype',
						 scope: {
							 fields: ['teamtypekey', 'description']
						 }
					}
				}
			}
		})
		.then(resp => {
			const data = JSON.parse(JSON.stringify(resp));
			data.forEach(at => {
				if(at.actortypeagency.length > 0) {
					at.teamtype = at.actortypeagency.map(ata => ata.teamtype);
				}
				delete at.actortypeagency;
			})
			return data;
		})
		.catch(err => err);
	};

	Actortype.add = request => {
		const actorType = request;
		const agencyTypes = request.agencytype;
		return Actortype.create(actorType)
		.then(data => {
			var prs = agencyTypes.map(at => app.models.Actortypeagency.create({
				teamtypekey: at,
				actortypekey: request.actortype
			}));
			return Promise.all(prs);
		})
		.then(data => {
			return data;
		})
		.catch(err => util.logError(err));
	};

	Actortype.listActortype = async function(request,reqctx) {
		var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		}  
        var requestuserinfo = {'token': '', 'email': _email};
		var teamtypekey ;
    	await util.getuserinfo(requestuserinfo).then (data => {
			teamtypekey = data.teamtypekey;
		});
		var datypeid= request.where.datypeid;

		const sql = 'Select * from getactortype($1, $2)';
		return util.executeSecondaryNodeDBQuery(sql, [teamtypekey, datypeid])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				return util.logError(err);
			});
	};

	Actortype.beforeRemote('list', function(ctx, data, next) {
		
		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			
			Actortype.count(JSON.parse(ctx.req.query.filter).where, function(err, count) {

				if (err) {
					throw err;
				}
				LOGGER.info("count : " + count);
				
				totalCount = count;

			});

		}

		next();
	});

	Actortype.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});

	Actortype.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : '',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

	Actortype.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			path: '/list',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

	Actortype.remoteMethod('listActortype', {
		accepts : [{
			arg : 'filter',
			type : 'Object',
			http : {source : 'query'},
			required : true},
			{arg: 'reqctx', type: 'object',
			http: {source: 'context'}}],
		http : {
			path: '/listActortype',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

	Actortype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Actortype.observe('access', (ctx, next) => util.access(ctx, next));
	Actortype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};