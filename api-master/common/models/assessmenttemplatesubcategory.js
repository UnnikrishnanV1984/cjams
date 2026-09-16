'use strict';
const util = require('../utils/utils');

module.exports = function(Assessmenttemplatesubcategory) {
    
    	Assessmenttemplatesubcategory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Assessmenttemplatesubcategory.observe('access', (ctx, next) => util.access(ctx, next));
	Assessmenttemplatesubcategory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next)); 

};
