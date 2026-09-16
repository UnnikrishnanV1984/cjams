'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Visitationlogclient) {

    Visitationlogclient.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Visitationlogclient.observe('access', (ctx, next) => util.access(ctx, next));
    Visitationlogclient.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}

