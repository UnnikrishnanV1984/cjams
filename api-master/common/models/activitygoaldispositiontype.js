'use strict';
const util = require('../utils/utils');

module.exports = function(Activitygoaldispositiontype) {

    
    Activitygoaldispositiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activitygoaldispositiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Activitygoaldispositiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
