'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Gapratesrevision) { 
    Gapratesrevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Gapratesrevision.observe('access', (ctx, next) => util.access(ctx, next));
    Gapratesrevision.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    