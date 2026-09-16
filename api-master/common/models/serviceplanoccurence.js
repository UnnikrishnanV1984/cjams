'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanoccurence) {    
    Serviceplanoccurence.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanoccurence.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanoccurence.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    