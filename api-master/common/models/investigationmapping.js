'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');

module.exports = function(Investigationmapping) {
    Investigationmapping.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationmapping.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationmapping.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}