'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Referencevalues) {
    
    Referencevalues.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Referencevalues.observe('access', (ctx, next) => util.access(ctx, next));
    Referencevalues.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}