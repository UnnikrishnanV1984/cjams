'use strict';
const util = require('../utils/utils');

module.exports = function(Personservicetype) {
    
    Personservicetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personservicetype.observe('access', (ctx, next) => util.access(ctx, next));
    Personservicetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
