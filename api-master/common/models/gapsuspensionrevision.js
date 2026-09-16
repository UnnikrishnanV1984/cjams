'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Gapsuspensionrevision) { 
    Gapsuspensionrevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Gapsuspensionrevision.observe('access', (ctx, next) => util.access(ctx, next));
    Gapsuspensionrevision.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    