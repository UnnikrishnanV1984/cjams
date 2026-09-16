'use strict';
const util = require('../utils/utils');


module.exports = function(Activitytaskstatustype) {

    Activitytaskstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activitytaskstatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Activitytaskstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
