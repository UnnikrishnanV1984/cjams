'use strict';
const util = require('../utils/utils');

module.exports = function(ServiceAgreementList) {

	ServiceAgreementList.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	ServiceAgreementList.observe('access', (ctx, next) => util.access(ctx, next));
	ServiceAgreementList.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};