'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Gradetype) {

    Gradetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Gradetype.observe('access', (ctx, next) => util.access(ctx, next));
    Gradetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}    