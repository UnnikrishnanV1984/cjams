'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeserreqinterstatewarranttypeconfig) {
    
    Intakeserreqinterstatewarranttypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeserreqinterstatewarranttypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeserreqinterstatewarranttypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}