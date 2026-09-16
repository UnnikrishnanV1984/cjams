'use strict';
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Personmedicalconditioninfo) {
    Personmedicalconditioninfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personmedicalconditioninfo.observe('access', (ctx, next) => util.access(ctx, next));
    Personmedicalconditioninfo.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};