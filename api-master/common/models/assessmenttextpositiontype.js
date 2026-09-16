'use strict';
const util = require('../utils/utils');

module.exports = function(Assessmenttextpositiontype) {

    
    	Assessmenttextpositiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Assessmenttextpositiontype.observe('access', (ctx, next) => util.access(ctx, next));
	Assessmenttextpositiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next)); 


};
