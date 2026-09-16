'use strict';
const util = require('../utils/utils');

module.exports = function(Documentattachment) {
    
    Documentattachment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Documentattachment.observe('access', (ctx, next) => util.access(ctx, next));
    Documentattachment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
