'use strict';
const util = require('../utils/utils');

module.exports = function(Saoresponseconditiontype) {
  
    Saoresponseconditiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Saoresponseconditiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Saoresponseconditiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}