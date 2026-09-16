'use strict';
const loopback = require('loopback');
const ds = loopback.createDataSource('memory'); 
var server = require('../../server/server');
const util = require('../utils/utils');


module.exports = function(Intakeservicerequestillegalactivity) {	 
    
    Intakeservicerequestillegalactivity.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestillegalactivity.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestillegalactivity.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
