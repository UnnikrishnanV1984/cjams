'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservreqevaluationconfig) {
    Intakeservreqevaluationconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqevaluationconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqevaluationconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
