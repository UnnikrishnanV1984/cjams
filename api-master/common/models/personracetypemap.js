'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Personracetypemap) {

 
        
    Personracetypemap.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personracetypemap.observe('access', (ctx, next) => util.access(ctx, next));
    Personracetypemap.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
