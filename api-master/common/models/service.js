'use strict';
const util = require('../utils/utils');

module.exports = function(service) {
    
    service.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    service.observe('access', (ctx, next) => util.access(ctx, next));
    service.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
