'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservsubtype) {

	Intakeservsubtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Intakeservsubtype.observe('access', (ctx, next) => util.access(ctx, next));
	Intakeservsubtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};