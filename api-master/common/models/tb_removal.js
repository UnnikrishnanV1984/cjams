'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_removal) {

    Tb_removal.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_removal.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_removal.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}