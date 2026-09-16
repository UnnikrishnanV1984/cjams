'use strict';
const util = require('../utils/utils');

module.exports = function(Informationsourcetype) {

    Informationsourcetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Informationsourcetype.observe('access', (ctx, next) => util.access(ctx, next));
    Informationsourcetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
