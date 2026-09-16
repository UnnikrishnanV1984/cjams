'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservrequestsdmmaltreatment) {
    Intakeservrequestsdmmaltreatment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Intakeservrequestsdmmaltreatment.observe('access', (ctx, next) => util.access(ctx, next));
	Intakeservrequestsdmmaltreatment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
 
}