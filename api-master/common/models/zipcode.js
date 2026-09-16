'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Zipcode) {
    Zipcode.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Zipcode.observe('access', (ctx, next) => util.access(ctx, next));
    Zipcode.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}