'use strict';
const util = require('../utils/utils');

module.exports = function(permanencyplansubtype) {

    permanencyplansubtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    permanencyplansubtype.observe('access', (ctx, next) => util.access(ctx, next));
    permanencyplansubtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
