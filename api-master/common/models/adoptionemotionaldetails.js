'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Adoptionemotionaldetails) {
    Adoptionemotionaldetails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionemotionaldetails.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionemotionaldetails.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    