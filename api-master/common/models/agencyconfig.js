'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Agencyconfig) {

    Agencyconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Agencyconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Agencyconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}    