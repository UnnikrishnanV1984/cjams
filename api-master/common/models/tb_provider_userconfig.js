'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_provider_userconfig) {
    
    Tb_provider_userconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_provider_userconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_provider_userconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}