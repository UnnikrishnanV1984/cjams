'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Guardianship) { 
    Guardianship.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Guardianship.observe('access', (ctx, next) => util.access(ctx, next));
    Guardianship.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    