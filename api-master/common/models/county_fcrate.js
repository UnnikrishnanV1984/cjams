'use strict';
const util = require('../utils/utils');

module.exports = function(County_fcrate) {
	County_fcrate.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	County_fcrate.observe('access', (ctx, next) => util.access(ctx, next));
	County_fcrate.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
