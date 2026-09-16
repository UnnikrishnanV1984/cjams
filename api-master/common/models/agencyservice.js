'use strict';
const util = require('../utils/utils');

module.exports = function(Agencyservice) {

    
    Agencyservice.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Agencyservice.observe('access', (ctx, next) => util.access(ctx, next));
    Agencyservice.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
