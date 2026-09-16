'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Healthdomaintype) {

    Healthdomaintype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Healthdomaintype.observe('access', (ctx, next) => util.access(ctx, next));
    Healthdomaintype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}    