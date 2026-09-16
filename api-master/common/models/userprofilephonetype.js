'use strict';
const util = require('../utils/utils');

module.exports = function(Userprofilephonetype) {

    Userprofilephonetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userprofilephonetype.observe('access', (ctx, next) => util.access(ctx, next));
    Userprofilephonetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
