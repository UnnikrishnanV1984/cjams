'use strict';
const util = require('../utils/utils');

module.exports = function(Investigationallegationstatustype) {

   	 Investigationallegationstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Investigationallegationstatustype.observe('access', (ctx, next) => util.access(ctx, next));
	Investigationallegationstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
 

};
