'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanstatustype) {    
    Serviceplanstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanstatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    