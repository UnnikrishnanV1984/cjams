'use strict';
const util = require('../utils/utils');


module.exports = function(Associatedpetitionsconfig) {

    Associatedpetitionsconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Associatedpetitionsconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Associatedpetitionsconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next)); 

};
