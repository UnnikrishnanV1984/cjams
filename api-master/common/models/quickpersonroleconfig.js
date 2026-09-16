'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Quickpersonroleconfig) {
    


	Quickpersonroleconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Quickpersonroleconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Quickpersonroleconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
