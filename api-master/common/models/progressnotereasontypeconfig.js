'use strict';
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var app = require('../../server/server');
const util = require('../utils/utils');


module.exports = function (Progressnotereasontypeconfig) {
  
  
    
    
    Progressnotereasontypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Progressnotereasontypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Progressnotereasontypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
        


}