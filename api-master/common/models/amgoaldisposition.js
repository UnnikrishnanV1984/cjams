'use strict';
const util = require('../utils/utils');

module.exports = function(Amgoaldisposition) {
     
    Amgoaldisposition.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Amgoaldisposition.observe('access', (ctx, next) => util.access(ctx, next));
    Amgoaldisposition.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
 

};
