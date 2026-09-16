'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function (Intakeservicerequestsafetyplanaction) {
	Intakeservicerequestsafetyplanaction.observe('before save',(ctx,next) => util.beforesave(ctx,next));
	Intakeservicerequestsafetyplanaction.observe('access',(ctx,next) => util.access(ctx,next));
	Intakeservicerequestsafetyplanaction.beforeRemote('*',(ctx,data,next) => util.beforeremote(ctx,next));
}
