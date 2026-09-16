'use strict';
const util = require('../utils/utils');

module.exports = function(Activitygoalstatustype) {

    
	Activitygoalstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activitygoalstatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Activitygoalstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
