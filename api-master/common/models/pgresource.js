'use strict';
const util = require('../utils/utils');

module.exports = function(Pgresource) { 

    Pgresource.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Pgresource.observe('access', (ctx, next) => util.access(ctx, next));
	Pgresource.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}