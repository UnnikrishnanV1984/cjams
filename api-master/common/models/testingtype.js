'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Testingtype) {
    
    Testingtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Testingtype.observe('access', (ctx, next) => util.access(ctx, next));
    Testingtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}    