'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservreqevalactorconfig) {
    Intakeservreqevalactorconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqevalactorconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqevalactorconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
