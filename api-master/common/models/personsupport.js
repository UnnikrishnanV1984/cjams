'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Personsupport) {    
    Personsupport.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personsupport.observe('access', (ctx, next) => util.access(ctx, next));
    Personsupport.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
