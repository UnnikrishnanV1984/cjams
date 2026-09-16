'use strict';
const util = require('../utils/utils');

module.exports = function(Locationfromtype) {

    Locationfromtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Locationfromtype.observe('access', (ctx, next) => util.access(ctx, next));
    Locationfromtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
