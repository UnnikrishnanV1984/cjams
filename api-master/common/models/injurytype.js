'use strict';
const util = require('../utils/utils');

module.exports = function(Injurytype) {

	Injurytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Injurytype.observe('access', (ctx, next) => util.access(ctx, next));
    Injurytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};