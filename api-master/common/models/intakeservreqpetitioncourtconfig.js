'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservreqpetitioncourtconfig) {
    Intakeservreqpetitioncourtconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqpetitioncourtconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqpetitioncourtconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
