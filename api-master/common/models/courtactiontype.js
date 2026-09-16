'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Courtactiontype) {    
    Courtactiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Courtactiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Courtactiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    