'use strict';
const util = require('../utils/utils');

module.exports = function(Physicalattributetype) { 

    Physicalattributetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Physicalattributetype.observe('access', (ctx, next) => util.access(ctx, next));
	Physicalattributetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}