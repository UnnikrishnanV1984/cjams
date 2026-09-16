'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_receivable_offset) {
    Tb_receivable_offset.observe('before save',(ctx,next) => util.beforesave(ctx,next));
	Tb_receivable_offset.observe('access',(ctx,next) => util.access(ctx,next));
	Tb_receivable_offset.beforeRemote('*',(ctx,data,next) => util.beforeremote(ctx,next));
}