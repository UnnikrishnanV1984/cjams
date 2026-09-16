'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_placement_auto_validation_log) {
    
    Tb_placement_auto_validation_log.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_placement_auto_validation_log.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_placement_auto_validation_log.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}