'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservreqpetitionhearingconfig) {
    Intakeservreqpetitionhearingconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqpetitionhearingconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqpetitionhearingconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
