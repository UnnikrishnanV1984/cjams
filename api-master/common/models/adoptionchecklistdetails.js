'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Adoptionchecklistdetails) {
    Adoptionchecklistdetails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionchecklistdetails.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionchecklistdetails.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    