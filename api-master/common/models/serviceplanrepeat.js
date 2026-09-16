'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanrepeat) {    
    Serviceplanrepeat.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanrepeat.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanrepeat.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    