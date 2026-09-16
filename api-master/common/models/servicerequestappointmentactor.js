'use strict';
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Servicerequestappointmentactor) {    
    Servicerequestappointmentactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Servicerequestappointmentactor.observe('access', (ctx, next) => util.access(ctx, next));
    Servicerequestappointmentactor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}