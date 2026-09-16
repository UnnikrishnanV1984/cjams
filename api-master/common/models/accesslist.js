'use strict';
const LOGGER = require("log4js").getLogger("accesslist");
const util = require('../utils/utils');

module.exports = function(Accesslist) {
	
	Accesslist.addupdate= function(request, reqctx) {

		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 

	    if(request.servicerequesttypeconfigid !== undefined) {
			
	    	Accesslist.find({where: {and: [{servicerequesttypeconfigid: request.servicerequesttypeconfigid}]}},
				    function(err, records){
								var app = require('../../server/server');
				        if(records.length>0) {
				        	LOGGER.debug('check true');
				    		var sql = 'UPDATE Accesslist SET activeflag=0 WHERE servicerequesttypeconfigid = $1';
							util.executeDBQuery(sql, [request.servicerequesttypeconfigid]).then((resp)=>{
								LOGGER.info(resp);
							}).catch((error)=>{
								LOGGER.error(error);
								throw error;
							});
				    		Accesslist.updateAll({servicerequesttypeconfigid:request.servicerequesttypeconfigid}, {activeflag:0, updatedby:_securityusersid},function(err1, res){
								if (err1){
									LOGGER.error('error: ' + err1);
							        return;
							    }
						        	var loadnumberarray = request.loadnumber;
						        	 if(Array.isArray(loadnumberarray)){
								        	loadnumberarray.forEach(element => {

								        		var  loadnumberid = element;
								    			
								    			var sql1 = "select * from Accesslist WHERE servicerequesttypeconfigid =$1 AND loadnumber =$2";
												util.executeDBQuery(sql1, [request.servicerequesttypeconfigid,loadnumberid]).then((resp)=>{
													addupdateAccessList(resp, request, loadnumberid);  
												}).catch((error)=>{
													Logger.error(error);
													throw error;
												});
								        	});
								        	
						        	 }

							});
				            // no matching records exist!
						} 
						else if (records.length === 0){
							LOGGER.debug('aaaaa')
                            var req = getAccesslist(request, request.loadnumber)
							
							LOGGER.debug('bbbb'+req)
                                
								return Promise.all(req.map(newreq => app.models.Accesslist.create(newreq)))
								.then(data => data)
								.catch(err1 =>err1);
								
						}
				            
				    });

	    	return Promise.resolve("Success");
	    	//Find the load Number for the Service Request ID
        	
	   	
	}
	     
		return Promise.resolve('Invalid request');
	};
	function getAccesslist(request, loadnumberarray){
		var req= [];
		for(const element of loadnumberarray){
			var temp = {
				"loadnumber" : element,
				"servicerequesttypeconfigid":request.servicerequesttypeconfigid,
				"activeflag":1
			}
			req.push(temp);
			LOGGER.debug('44444'+JSON.stringify(req))
		}
		return req;
	}

	function addupdateAccessList(results, request, loadnumberid) {
		if (results.length>0){
			var sql2 = 'UPDATE Accesslist SET activeflag=1 WHERE servicerequesttypeconfigid =$1 AND loadnumber =$2';
			LOGGER.debug('--SQL111111111-->>>>>'+sql2);
			LOGGER.debug('value----->>>>>>'+sql2);
			 return util.executeDBQuery(sql2,[request.servicerequesttypeconfigid,loadnumberid])
				 .catch(err => {
					 LOGGER.error('>>>>ERROR:', err);
					 throw err;
				 });

		}else if(results.length === 0){
			var sql3 = 'INSERT INTO Accesslist (servicerequesttypeconfigid,loadnumber,activeflag) VALUES ($1,$2,$3)';
	   LOGGER.debug("inside---->>>>>")
	   LOGGER.debug("coming---->>>>>"+sql3)
		  var activeflag = 1;
			return util.executeDBQuery(sql3,[request.servicerequesttypeconfigid,loadnumberid,activeflag])
				 .catch(err => {
					 LOGGER.error('>>>>ERROR:', err);
					 throw err;
				 });
		}
	}
	
	Accesslist.remoteMethod(
			'addupdate', 
				    {
				      http: {
				      		path: '/addupdate',
				      		verb: 'post'
				      },
				     accepts : [ {arg : 'data',type : 'object',
					 http : {source : 'body'}},
							 {arg: 'req', type: 'object',
					 http: { source: 'req'}}, {
						 arg: 'reqctx',
						 type: 'object',
						 http: {source: 'context'}
					   } ],   
				      returns: {
				    	  type : 'object',
							root : true
				      }
				     }
		);

	Accesslist.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Accesslist.observe('access', (ctx, next) => util.access(ctx, next));
	Accesslist.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
