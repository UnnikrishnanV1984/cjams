'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_placement_revision) {
    
    Tb_placement_revision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_placement_revision.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_placement_revision.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}