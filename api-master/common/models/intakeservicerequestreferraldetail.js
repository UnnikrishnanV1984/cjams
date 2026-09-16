'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestfreferraldetail) {

    	Intakeservicerequestfreferraldetail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Intakeservicerequestfreferraldetail.observe('access', (ctx, next) => util.access(ctx, next));
	Intakeservicerequestfreferraldetail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};