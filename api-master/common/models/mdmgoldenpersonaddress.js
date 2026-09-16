'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(mdmgoldenpersonaddress) {

    mdmgoldenpersonaddress.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    mdmgoldenpersonaddress.observe('access', (ctx, next) => util.access(ctx, next));
    mdmgoldenpersonaddress.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}