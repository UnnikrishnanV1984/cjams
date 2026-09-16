'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeagencyserv) {

	Intakeagencyserv.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeagencyserv.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeagencyserv.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};