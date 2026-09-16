'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var config = require('../../server/config.json');

module.exports = function (Provideryouthinfo) {
                 
Provideryouthinfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Provideryouthinfo.observe('access', (ctx, next) => util.access(ctx, next));
Provideryouthinfo.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
