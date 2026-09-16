'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_receivable_liquidation) {

    

    Tb_receivable_liquidation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_receivable_liquidation.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_receivable_liquidation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}