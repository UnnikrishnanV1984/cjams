'use strict';
const util = require('../utils/utils');

module.exports = function(Agencyarea) {

	Agencyarea.observe('before save', (ctx, next) => util.beforesave(ctx, next));
   	Agencyarea.observe('access', (ctx, next) => util.access(ctx, next));
    	Agencyarea.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
