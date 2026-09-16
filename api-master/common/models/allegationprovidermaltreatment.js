'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Allegationprovidermaltreatment) {
	Allegationprovidermaltreatment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Allegationprovidermaltreatment.observe('access', (ctx, next) => util.access(ctx, next));
    Allegationprovidermaltreatment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
