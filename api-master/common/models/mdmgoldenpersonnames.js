'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(mdmgoldenpersonnames) {

    mdmgoldenpersonnames.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    mdmgoldenpersonnames.observe('access', (ctx, next) => util.access(ctx, next));
    mdmgoldenpersonnames.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}