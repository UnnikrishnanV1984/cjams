'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Dentalspecialtytype) {    
    Dentalspecialtytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Dentalspecialtytype.observe('access', (ctx, next) => util.access(ctx, next));
    Dentalspecialtytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
