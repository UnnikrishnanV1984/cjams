'use strict';
const util = require('../utils/utils');

module.exports = function(Assessmenttemplatetarget) {
	 
	Assessmenttemplatetarget.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Assessmenttemplatetarget.observe('access', (ctx, next) => util.access(ctx, next));
	Assessmenttemplatetarget.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
