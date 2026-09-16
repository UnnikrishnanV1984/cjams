'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Offensecategory) {
	
	Offensecategory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Offensecategory.observe('access', (ctx, next) => util.access(ctx, next));
	Offensecategory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
