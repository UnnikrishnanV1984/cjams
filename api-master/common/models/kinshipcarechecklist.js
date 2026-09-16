'use strict';
const util = require('../utils/utils');
module.exports = function(Kinshipcarechecklist) {   
    Kinshipcarechecklist.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Kinshipcarechecklist.observe('access', (ctx, next) => util.access(ctx, next));
    Kinshipcarechecklist.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};