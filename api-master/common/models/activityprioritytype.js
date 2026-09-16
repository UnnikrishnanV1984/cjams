'use strict';
const util = require('../utils/utils');

module.exports = function(Activityprioritytype) {

    Activityprioritytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Activityprioritytype.observe('access', (ctx, next) => util.access(ctx, next));
	Activityprioritytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
