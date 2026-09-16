'use strict';
const LOGGER = require("log4js").getLogger("allegationstatestatutes");
const util = require('../utils/utils');

module.exports = function(Allegationstatestatutes) {
	
	
	Allegationstatestatutes.addupdate= function(request) {

	Allegationstatestatutes.find({where: {and: [{allegationid: request.allegationid}]}},
		    function(_err, records){
						var app = require('../../server/server');
		        if(records.length>0) {
		        	LOGGER.debug('check true');
		    		Allegationstatestatutes.updateAll({allegationid:request.allegationid}, {activeflag:0},function(err1, res){
						if (err1){
							LOGGER.error('>>>>ERROR:', err1);
							throw err1;
					    }
						else{
							addUpdateallegationstatestatutes(request)
						}
					});
		            // no matching records exist!
		        } else {
					var req= [];
					var statestatutesarray = request.statestatutesid;

					for(const element of statestatutesarray){
						var tempreq = {
							"allegationid" : request.allegationid,
							"statestatuteid":element
						}
						req.push(tempreq);
						LOGGER.debug('44444'+JSON.stringify(req))
					}

						return Promise.all(req.map(newreq => app.models.Allegationstatestatutes.create(newreq)))
						.then(data => data)
						.catch(err1 =>err1);
				}
		    });

			return Promise.resolve("Success");
	}

	function addUpdateallegationstatestatutes(request){
		var statestatutesarray = request.statestatutesid
							
		if(Array.isArray(statestatutesarray)){
			
			statestatutesarray.forEach(element => {
				var statestatutesid = element;
				LOGGER.debug("tempid--->" + statestatutesid);
				var sql1 = "select * from allegationstatestatutes WHERE allegationid =$1 AND statestatuteid =$2";

				util.executeDBQuery(sql1, [request.allegationid, statestatutesid])
					.then((results) => {
						LOGGER.info(results);
						if (results.length > 0) {
							var sql2 = 'UPDATE allegationstatestatutes SET activeflag=1 WHERE allegationid =$1 AND statestatuteid =$2';
							util.executeDBQuery(sql2, [request.allegationid, statestatutesid])
								.then((resp) => {
									LOGGER.info(resp);
								}).catch(err => {
									LOGGER.error('>>>>ERROR:', err);
									throw err;
								});
						} else if (results.length === 0) {

							var sql3 = 'INSERT INTO allegationstatestatutes (allegationid,statestatuteid) VALUES ($1,$2)';
							util.executeDBQuery(sql3, [request.allegationid, statestatutesid])
								.then((resp) => {
									LOGGER.info(resp);
								}).catch(err => {
									LOGGER.error('>>>>ERROR:', err);
									throw err;
								});
						}
					}).catch(err => {
						LOGGER.error('>>>>ERROR:', err);
						throw err;
					});
			});
		}
	}

	
	Allegationstatestatutes.remoteMethod(
			'addupdate', 
				    {
				      http: {
				      		path: '/addupdate',
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

		Allegationstatestatutes.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Allegationstatestatutes.observe('access', (ctx, next) => util.access(ctx, next));
		Allegationstatestatutes.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
		
};
