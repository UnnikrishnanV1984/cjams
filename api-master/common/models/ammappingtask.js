'use strict';
const util = require('../utils/utils');

module.exports = function(Ammappingtask) {

    Ammappingtask.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Ammappingtask.observe('access', (ctx, next) => util.access(ctx, next));
    Ammappingtask.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
