'use strict';
const LOGGER = require("log4js").getLogger("rule");
const loopback = require('loopback');
const ds = loopback.createDataSource('memory'); 
var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Rule) {
  
	 
  /*  Rule.observe('before save', function setdefaults(ctx, next) {
       
        LOGGER.debug(ctx.where);
        const currentDate = new Date().toLocaleString();
    
        //if(ctx.data.investigationallegationid) {
        if( ctx.where!=null && ctx.where!=undefined && ctx.where.ruleid !=null && ctx.where.ruleid!=undefined  ) {
            LOGGER.debug(ctx);
        //    currentInstance:
            ctx.data.updatedby = app.currentUser.securityusersid;
            ctx.data.updatedon = currentDate;
        }
        else {
            ctx.instance.insertedby = app.currentUser.securityusersid;
            ctx.instance.insertedon = currentDate;
            ctx.instance.updatedby = app.currentUser.securityusersid;
             
            if (ctx.instance.activeflag === null || ctx.instance.activeflag === undefined) ctx.instance.activeflag = 1;
        }
        next();
      }); */
	 
	Rule.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Rule.observe('access', (ctx, next) => util.access(ctx, next));
	Rule.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
