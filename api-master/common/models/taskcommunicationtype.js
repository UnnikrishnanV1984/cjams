'use strict';
const util = require('../utils/utils');

module.exports = function(Taskcommunicationtype) {
	 
	Taskcommunicationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Taskcommunicationtype.observe('access', (ctx, next) => util.access(ctx, next));
	Taskcommunicationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
