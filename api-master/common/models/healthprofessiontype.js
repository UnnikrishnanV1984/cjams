'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Healthprofessiontype) {

    Healthprofessiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Healthprofessiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Healthprofessiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}    