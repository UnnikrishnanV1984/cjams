'use strict';
const util = require('../utils/utils');

module.exports = function(State) {

	State.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	State.observe('access', (ctx, next) => util.access(ctx, next));
	State.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
