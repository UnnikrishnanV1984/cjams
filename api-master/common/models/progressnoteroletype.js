'use strict';
const util = require('../utils/utils');

module.exports = function(Progressnoteroletype) {

	Progressnoteroletype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Progressnoteroletype.observe('access', (ctx, next) => util.access(ctx, next));
	Progressnoteroletype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
