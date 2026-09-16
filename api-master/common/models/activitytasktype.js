'use strict';
const util = require('../utils/utils');

module.exports = function(Activitytasktype) {

    
    Activitytasktype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activitytasktype.observe('access', (ctx, next) => util.access(ctx, next));
    Activitytasktype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
