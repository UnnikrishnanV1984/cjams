'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeserreqinterstate) {
    
    Intakeserreqinterstate.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeserreqinterstate.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeserreqinterstate.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}