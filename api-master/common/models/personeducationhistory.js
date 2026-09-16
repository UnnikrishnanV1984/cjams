'use strict';
const util = require('../utils/utils');

module.exports = function(Personeducationhistory) {
   
    Personeducationhistory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personeducationhistory.observe('access', (ctx, next) => util.access(ctx, next));
    Personeducationhistory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
