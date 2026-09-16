'use strict';
const LOGGER = require("log4js").getLogger("hearingclients");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Hearingclients) {
    Hearingclients.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Hearingclients.observe('access', (ctx, next) => util.access(ctx, next));
    Hearingclients.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}