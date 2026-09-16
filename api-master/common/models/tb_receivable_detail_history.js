'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_receivable_detail_history) {
 
    
    
    Tb_receivable_detail_history.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_receivable_detail_history.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_receivable_detail_history.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}