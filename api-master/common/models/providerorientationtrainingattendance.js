'use strict';
const LOGGER = require("log4js").getLogger("providerorientationtrainingattendance");
var app = require('../../server/server');
const util = require('../utils/utils');
var config = require('../../server/config.json');
var email = require('./email');

module.exports = function (Providerorientationtrainingattendance) {

  Providerorientationtrainingattendance.getassignedorientations = function (request) {
    var payload = [];
    let getappstaff = '';
    if (request.where.object_id) {
      payload.push(request.where.object_id);
      payload.push(request.where.training_type);
      getappstaff = 'select * from providerorientationtrainingattendance pota join providerorientationtraining pot on pota.orientation_training_id = pot.orientation_training_id  where pota.object_id =$1 and pot.training_type = $2 order by pota.training_number asc';
    } else if (request.where.training_number) {
      payload.push(request.where.training_number);
      getappstaff = 'select * from providerorientationtrainingattendance pota join providerorientationtraining pot on pota.orientation_training_id = pot.orientation_training_id  where pota.training_number =$1 and pota.is_intent_to_attend = true order by pota.training_number asc';
    }
    return util.executeDBQuery(getappstaff, payload)
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
};

Providerorientationtrainingattendance.remoteMethod(
    'getassignedorientations', {
          http: {
                path: '/getassignedorientations',
                verb: 'post'
          },
          accepts: {
                arg: 'data',
                type: 'object',
                http: {
                      source: 'body'
                }
          },
          returns: {
                type: 'object',
                root: true
          }
    }
);

  Providerorientationtrainingattendance.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Providerorientationtrainingattendance.observe('access', (ctx, next) => util.access(ctx, next));
  Providerorientationtrainingattendance.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};