'use strict';
const util = require('../utils/utils');
module.exports = function(Kinshipcaredocuments) { 
    Kinshipcaredocuments.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Kinshipcaredocuments.observe('access', (ctx, next) => util.access(ctx, next));
    Kinshipcaredocuments.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};