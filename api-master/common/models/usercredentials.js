'use strict';
const LOGGER = require("log4js").getLogger("usercredentials");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Usercredentials) {

//login service
  Usercredentials.login = function(username,password) {
  	LOGGER.debug("username:: "+username)
  	LOGGER.debug("password:: "+password )
  	let var_securityuserid;
  	app.models.Securityusers.findOne({
  		where : {
  			username : username
  		}}, function(err1, res){
  			LOGGER.debug("res::"+res)
  			if(err1) {LOGGER.error(err1)}
  			else {
  				var_securityuserid = res.securityusersid;
  				LOGGER.debug(res.username,var_securityuserid);
  				Usercredentials.findOne({
  				where : {
  					securityusersid : var_securityuserid
  				}}, function(err,result){
  					if(err) {LOGGER.error(err)}
  					else {
  						LOGGER.debug("password :: " +result.password);
  					}
  				});
  			}
  		});
  };
 

  Usercredentials.remoteMethod('login',{
			http: {path: '/login', verb: 'post'},
			accepts: [
				{arg: 'username', type: 'string',http: {source: 'form'}},
      	{arg: 'password', type: 'string',http: {source: 'form'}}
      			 ],
  			returns:[
        			{arg: 'message', type: 'string'},
        			{arg: 'id', type: 'string'}
        		]		
		  });
		  
	Usercredentials.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Usercredentials.observe('access', (ctx, next) => util.access(ctx, next));
	Usercredentials.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));		  
}
