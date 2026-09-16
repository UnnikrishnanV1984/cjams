'use strict';
const util = require('../utils/utils');

module.exports = function(Servicesubtype) {

    Servicesubtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Servicesubtype.observe('access', (ctx, next) => util.access(ctx, next));
    Servicesubtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
