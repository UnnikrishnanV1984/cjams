'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Collateralroleconfig) {
    


	Collateralroleconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Collateralroleconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Collateralroleconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
