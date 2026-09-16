'use strict';

var app = require('../../server/server');
var ds = app.dataSources.hcuewelfare;
const util = require('../utils/utils');

module.exports = function(Reviewparticipants) {
    
	
    Reviewparticipants.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Reviewparticipants.observe('access', (ctx, next) => util.access(ctx, next));
    Reviewparticipants.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
