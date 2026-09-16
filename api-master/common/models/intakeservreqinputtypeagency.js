'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservreqinputtypeagency) {


    Intakeservreqinputtypeagency.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Intakeservreqinputtypeagency.observe('access', (ctx, next) => util.access(ctx, next));
	Intakeservreqinputtypeagency.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
}