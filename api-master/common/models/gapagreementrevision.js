'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Gapagreementrevision) { 
    Gapagreementrevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Gapagreementrevision.observe('access', (ctx, next) => util.access(ctx, next));
    Gapagreementrevision.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    