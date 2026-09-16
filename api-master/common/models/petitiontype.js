'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Petitiontype) {    
    Petitiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Petitiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Petitiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
