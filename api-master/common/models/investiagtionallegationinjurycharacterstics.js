'use strict';
const util = require('../utils/utils');

module.exports = function(investiagtionallegationinjurycharacterstics) {
    
    investiagtionallegationinjurycharacterstics.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    investiagtionallegationinjurycharacterstics.observe('access', (ctx, next) => util.access(ctx, next));
    investiagtionallegationinjurycharacterstics.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};