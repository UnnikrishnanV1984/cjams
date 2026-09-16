'use strict';
const util = require('../utils/utils');

module.exports = function(Countyareateammember) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
	var totalCount;
	Countyareateammember.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Countyareateammember.find(request);

	};

	Countyareateammember.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined'
				&& JSON.parse(ctx.req.query.filter).page === 1) {

			Countyareateammember.count(function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Countyareateammember.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Countyareateammember.remoteMethod('list', {
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
	
/*	Countyareateammember.insert = function(request, cb) {

		var property;
		
		for(property in request.id) {
	        var value = request.id[property];
	    } 
		
		/*
		   SELECT * FROM Region;
           SELECT * FROM COUNTY WHERE ACTIVEFLAG = 1
           SELECT * FROM COUNTY WHERE ACTIVEFLAG = 1 AND apsregion = 4 and CountyName = 'Jackson'
           SELECT * from countyAreaTeamMember where TeamMemberId = ?? and 
		
		
		Countyareateammember.find(request, function(err, res) {
			cb(err, res);
		});

	};*/
	
	Countyareateammember.addupdate= function(request, reqctx) {
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;

	    if(request.teammemberid !== undefined) {
	    return 	Countyareateammember.find({where:{teammemberid: request.teammemberid}}).then(data => {
			 if(data.length > 0){
				  Countyareateammember.updateAll({teammemberid:request.teammemberid}, {activeflag:0, updatedby: _securityusersid})
			 }else if (data.length == 0){
				var countidarray = request.countyid;
				if(Array.isArray(countidarray)){
					countidarray.forEach(element => {
						var  countid = element;
						var activeflag = 1;
						 Countyareateammember.upsert({teammemberid:request.teammemberid,
							countyid:countid,
							activeflag:activeflag,
							effectivedate:request.effectivedate})
					})}
			 }
			 findandUpdateCounty(request, _securityusersid);
		})
	}
	return Promise.resolve('Invalid request');
}

	function findandUpdateCounty(request, _securityusersid) {
		var countidarray = request.countyid;
		if (Array.isArray(countidarray)) {
			countarray.push(
				countidarray.map(element => {
					var countid = element;
					return Countyareateammember.find({ where: { and: [{ teammemberid: request.teammemberid,countyid: countid }] } })
						.then(lis => {
							if (lis.length > 0) {
								Countyareateammember.updateAll({ teammemberid: request.teammemberid,countyid: countid },{ activeflag: 1,updatedby: _securityusersid })
							} else if (lis.length == 0) {
								var activeflag = 1;
								Countyareateammember.upsert({
									teammemberid: request.teammemberid,
									countyid: countid,
									activeflag: activeflag,
									effectivedate: request.effectivedate
								})
							}
						})
				})
			)
			var flatPrs = countarray.reduce(function (a,b) { return a.concat(b) },[]);
			return Promise.all(flatPrs)
				.then(data => "success")
				.catch(err => err);
		}
	}


	Countyareateammember.remoteMethod(
			'addupdate', 
				    {
				      http: {
				      		path: '/addupdate',
				      		verb: 'post'
				      },
				     accepts : [ {arg : 'data',type : 'object',
				     		http : {source : 'body'}},  {
								arg: 'reqctx',
								type: 'object',
								http: {
								  source: 'context'
								}
							  } ],   
				      returns: {
				    	  type : 'object',
							root : true
				      }
				     }
		);

		Countyareateammember.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Countyareateammember.observe('access', (ctx, next) => util.access(ctx, next));
		Countyareateammember.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
