'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Educationtype) {
    
    Educationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Educationtype.observe('access', (ctx, next) => util.access(ctx, next));
    Educationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}    