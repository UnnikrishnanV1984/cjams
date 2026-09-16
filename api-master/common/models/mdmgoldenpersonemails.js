'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(mdmgoldenpersonemails) {

    mdmgoldenpersonemails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    mdmgoldenpersonemails.observe('access', (ctx, next) => util.access(ctx, next));
    mdmgoldenpersonemails.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}