'use strict';
const util = require('../utils/utils');

module.exports = function(Personrepresentativepayee) { 

    Personrepresentativepayee.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Personrepresentativepayee.observe('access', (ctx, next) => util.access(ctx, next));
	Personrepresentativepayee.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}