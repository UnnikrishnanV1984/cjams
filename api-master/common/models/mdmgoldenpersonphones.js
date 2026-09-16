'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(mdmgoldenpersonphones) {

    mdmgoldenpersonphones.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    mdmgoldenpersonphones.observe('access', (ctx, next) => util.access(ctx, next));
    mdmgoldenpersonphones.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}