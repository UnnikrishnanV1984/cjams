'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(courtordertype) {    
    courtordertype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    courtordertype.observe('access', (ctx, next) => util.access(ctx, next));
    courtordertype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
