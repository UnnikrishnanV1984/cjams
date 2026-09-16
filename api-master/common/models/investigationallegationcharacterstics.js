'use strict';
const util = require('../utils/utils');

module.exports = function(investigationallegationcharacterstics) {
    
    investigationallegationcharacterstics.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    investigationallegationcharacterstics.observe('access', (ctx, next) => util.access(ctx, next));
    investigationallegationcharacterstics.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};