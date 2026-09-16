'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Visitationplanclients) {

    Visitationplanclients.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Visitationplanclients.observe('access', (ctx, next) => util.access(ctx, next));
    Visitationplanclients.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}

