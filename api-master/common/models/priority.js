'use strict';
const util = require('../utils/utils');


module.exports = function(Priority) {

	Priority.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Priority.observe('access', (ctx, next) => util.access(ctx, next));
	Priority.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
