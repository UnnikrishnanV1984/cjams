'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Intakeservreqevalpetitionconfig) {
  Intakeservreqevalpetitionconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Intakeservreqevalpetitionconfig.observe('access', (ctx, next) => util.access(ctx, next));
  Intakeservreqevalpetitionconfig.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};
