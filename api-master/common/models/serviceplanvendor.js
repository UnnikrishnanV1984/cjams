'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanvendor) {    
    Serviceplanvendor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanvendor.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanvendor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}  