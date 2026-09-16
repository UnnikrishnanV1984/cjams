'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var config = require('../../server/config.json');
var email = require('./email');

module.exports = function (Providerapprovalphaserecord) {
  Providerapprovalphaserecord.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Providerapprovalphaserecord.observe('access', (ctx, next) => util.access(ctx, next));
  Providerapprovalphaserecord.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};