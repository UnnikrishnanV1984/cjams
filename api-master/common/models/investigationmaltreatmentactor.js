'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Investigationmaltreatmentactor) {


	Investigationmaltreatmentactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Investigationmaltreatmentactor.observe('access', (ctx, next) => util.access(ctx, next));
  Investigationmaltreatmentactor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
