'use strict';
const util = require('../utils/utils');

module.exports = function(Locationtotype) {

    Locationtotype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Locationtotype.observe('access', (ctx, next) => util.access(ctx, next));
    Locationtotype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
