'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Guardinmeetingboardmembers) { 




    Guardinmeetingboardmembers.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Guardinmeetingboardmembers.observe('access', (ctx, next) => util.access(ctx, next));
    Guardinmeetingboardmembers.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    

