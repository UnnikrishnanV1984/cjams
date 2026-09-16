'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Servicecaserequest) {
    Servicecaserequest.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Servicecaserequest.observe('access', (ctx, next) => util.access(ctx, next));
    Servicecaserequest.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}