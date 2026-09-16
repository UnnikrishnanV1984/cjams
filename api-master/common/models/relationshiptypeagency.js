'use strict';
const util = require('../utils/utils');

module.exports = function(Relationshiptypeagency) {


    Relationshiptypeagency.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Relationshiptypeagency.observe('access', (ctx, next) => util.access(ctx, next));
	Relationshiptypeagency.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
}