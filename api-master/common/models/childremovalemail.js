'use strict';
const util = require('../utils/utils');

module.exports = function(childremovalemail) {

	childremovalemail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	childremovalemail.observe('access', (ctx, next) => util.access(ctx, next));
	childremovalemail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
