'use strict';
const util = require('../utils/utils');

module.exports = function(YouthTransitionPlanServicePlanMap) {

    YouthTransitionPlanServicePlanMap.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    YouthTransitionPlanServicePlanMap.observe('access', (ctx, next) => util.access(ctx, next));
    YouthTransitionPlanServicePlanMap.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};