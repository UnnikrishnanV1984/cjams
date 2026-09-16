'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanactivitystatustype) {    
    Serviceplanactivitystatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanactivitystatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanactivitystatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    