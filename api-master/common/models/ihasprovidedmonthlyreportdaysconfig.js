'use strict';
const util = require('../utils/utils');

module.exports = function(Ihasprovidedmonthlyreportdaysconfig) {
    Ihasprovidedmonthlyreportdaysconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Ihasprovidedmonthlyreportdaysconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Ihasprovidedmonthlyreportdaysconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
