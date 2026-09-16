'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var config = require('../../server/config.json');
var email = require('./email');

module.exports = function (Publicproviderhomeinfo) {
  Publicproviderhomeinfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Publicproviderhomeinfo.observe('access', (ctx, next) => util.access(ctx, next));
  Publicproviderhomeinfo.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};