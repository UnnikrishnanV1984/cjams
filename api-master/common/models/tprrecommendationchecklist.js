'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Tprrecommendationchecklist) {
    Tprrecommendationchecklist.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tprrecommendationchecklist.observe('access', (ctx, next) => util.access(ctx, next));
    Tprrecommendationchecklist.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};