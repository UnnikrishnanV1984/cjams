'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(hearingtype) {    
    hearingtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    hearingtype.observe('access', (ctx, next) => util.access(ctx, next));
    hearingtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
