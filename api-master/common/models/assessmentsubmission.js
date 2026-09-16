'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Assessmentsubmission) {

    Assessmentsubmission.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Assessmentsubmission.observe('access', (ctx, next) => util.access(ctx, next));
	Assessmentsubmission.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
	
   
};
