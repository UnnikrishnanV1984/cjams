'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Quickpersonsubstconfig) {
    


	Quickpersonsubstconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Quickpersonsubstconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Quickpersonsubstconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
