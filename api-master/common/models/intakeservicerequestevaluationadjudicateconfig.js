'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestevaluationadjudicateconfig) {
    Intakeservicerequestevaluationadjudicateconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestevaluationadjudicateconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestevaluationadjudicateconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
