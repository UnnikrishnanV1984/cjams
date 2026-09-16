'use strict';
const util = require('../utils/utils');

module.exports = function(Investigationfindingassessors) {

    Investigationfindingassessors.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationfindingassessors.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationfindingassessors.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
