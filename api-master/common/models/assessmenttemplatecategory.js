'use strict';
const util = require('../utils/utils');

module.exports = function(Assessmenttemplatecategory) {
	 
	Assessmenttemplatecategory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Assessmenttemplatecategory.observe('access', (ctx, next) => util.access(ctx, next));
	Assessmenttemplatecategory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
