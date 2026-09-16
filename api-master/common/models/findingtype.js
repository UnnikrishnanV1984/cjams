'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Findingtype) {    
    Findingtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Findingtype.observe('access', (ctx, next) => util.access(ctx, next));
    Findingtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}  