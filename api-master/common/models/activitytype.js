'use strict';
const util = require('../utils/utils');

module.exports = function(Activitytype) {
    
    Activitytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activitytype.observe('access', (ctx, next) => util.access(ctx, next));
    Activitytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
