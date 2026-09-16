'use strict';
const util = require('../utils/utils');

module.exports = function(Activitygoaltype) {

    Activitygoaltype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activitygoaltype.observe('access', (ctx, next) => util.access(ctx, next));
    Activitygoaltype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
