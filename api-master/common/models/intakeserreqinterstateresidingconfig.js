'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeserreqinterstateresidingconfig) {
    
    Intakeserreqinterstateresidingconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeserreqinterstateresidingconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeserreqinterstateresidingconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}