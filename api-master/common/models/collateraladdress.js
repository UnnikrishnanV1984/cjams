'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Collateraladdress) {
    

  
  
	Collateraladdress.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Collateraladdress.observe('access', (ctx, next) => util.access(ctx, next));
    Collateraladdress.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
