'use strict';
const util = require('../utils/utils');

module.exports = function(Snapshothist) {

	Snapshothist.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Snapshothist.observe('access', (ctx, next) => util.access(ctx, next));
	Snapshothist.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};