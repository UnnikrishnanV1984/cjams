'use strict';
const util = require('../utils/utils');

module.exports = function(Agencyaddress) {

    Agencyaddress.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Agencyaddress.observe('access', (ctx, next) => util.access(ctx, next));
    Agencyaddress.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
