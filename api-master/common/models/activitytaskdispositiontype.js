'use strict';
const util = require('../utils/utils');

module.exports = function(Activitytaskdispositiontype) {

    Activitytaskdispositiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activitytaskdispositiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Activitytaskdispositiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
