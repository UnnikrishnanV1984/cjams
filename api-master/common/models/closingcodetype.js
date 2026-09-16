'use strict';
const util = require('../utils/utils');

module.exports = function(Closingcodetype) {

    Closingcodetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Closingcodetype.observe('access', (ctx, next) => util.access(ctx, next));
    Closingcodetype.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));


};
