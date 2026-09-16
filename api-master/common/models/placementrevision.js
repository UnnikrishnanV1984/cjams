'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Placementrevision) {
    
    Placementrevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Placementrevision.observe('access', (ctx, next) => util.access(ctx, next));
    Placementrevision.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}