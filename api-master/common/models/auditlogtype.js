'use strict';
const util = require('../utils/utils');

module.exports = function(Auditlogtype) {

	Auditlogtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Auditlogtype.observe('access', (ctx, next) => util.access(ctx, next));
	Auditlogtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};


