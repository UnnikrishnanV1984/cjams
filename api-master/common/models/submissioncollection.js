'use strict';
const util = require('../utils/utils');

module.exports = function(Submissioncollection) {

    Submissioncollection.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Submissioncollection.observe('access', (ctx, next) => util.access(ctx, next));
    Submissioncollection.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
