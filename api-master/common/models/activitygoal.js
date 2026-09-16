'use strict';
const util = require('../utils/utils');

module.exports = function(Activitygoal) {

    Activitygoal.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activitygoal.observe('access', (ctx, next) => util.access(ctx, next));
    Activitygoal.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
