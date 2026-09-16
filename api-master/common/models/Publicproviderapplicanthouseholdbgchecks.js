'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var config = require('../../server/config.json');
var email = require('../models/email');

module.exports = function (Publicproviderapplicanthouseholdbgchecks) {

    Publicproviderapplicanthouseholdbgchecks.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Publicproviderapplicanthouseholdbgchecks.observe('access', (ctx, next) => util.access(ctx, next));
    Publicproviderapplicanthouseholdbgchecks.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
