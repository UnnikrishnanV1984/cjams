'use strict';
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Progressnotesubtype) {
		
	 Progressnotesubtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	 Progressnotesubtype.observe('access', (ctx, next) => util.access(ctx, next));
	 Progressnotesubtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
