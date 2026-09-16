'use strict';
const util = require('../utils/utils');

module.exports = function(Injurycharactersticstype) {

	Injurycharactersticstype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Injurycharactersticstype.observe('access', (ctx, next) => util.access(ctx, next));
    Injurycharactersticstype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};