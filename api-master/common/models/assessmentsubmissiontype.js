'use strict';
const util = require('../utils/utils');

module.exports = function(Assessmentsubmissiontype) {
	 
	Assessmentsubmissiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Assessmentsubmissiontype.observe('access', (ctx, next) => util.access(ctx, next));
	Assessmentsubmissiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
