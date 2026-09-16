'use strict';
const util = require('../utils/utils');

module.exports = function(Personphysicalattribute) { 

    Personphysicalattribute.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Personphysicalattribute.observe('access', (ctx, next) => util.access(ctx, next));
	Personphysicalattribute.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}