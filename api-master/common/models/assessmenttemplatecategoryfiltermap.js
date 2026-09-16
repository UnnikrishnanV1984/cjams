'use strict';
const util = require('../utils/utils');

module.exports = function(Assessmenttemplatecategoryfiltermap) {
	 
	Assessmenttemplatecategoryfiltermap.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Assessmenttemplatecategoryfiltermap.observe('access', (ctx, next) => util.access(ctx, next));
	Assessmenttemplatecategoryfiltermap.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
