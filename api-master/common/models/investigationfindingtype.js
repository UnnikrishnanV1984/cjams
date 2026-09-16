'use strict';
const util = require('../utils/utils');

module.exports = function(Investigationfindingtype) {
    
    Investigationfindingtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationfindingtype.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationfindingtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};