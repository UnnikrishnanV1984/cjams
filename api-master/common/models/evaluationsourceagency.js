'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const pdf = require('../models/pdf');

module.exports = function(Evaluationsourceagency) {

    Evaluationsourceagency.remoteMethod('listEvaluationSourceAgency', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            path: '/listEvaluationSourceAgency',
            verb: 'get',
            
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

   Evaluationsourceagency.listEvaluationSourceAgency = request => {
        var intakeservicerequesttypeid ='';
        if(request.where) {
            intakeservicerequesttypeid = request.where.intakeservicerequesttypeid;
      }
      const sql = "select ESA.evaluationsourceagencykey,ESA.evaluationsourceagencyid,ESA.evaluationsourcetypekey,ESA.description  from evaluationsourceagency ESA "
      +" join evaluationsourcetype EST on EST.evaluationsourcetypekey = ESA.evaluationsourcetypekey and EST.activeflag=1 "
      +" join intakeservicerequesttype INST on INST.intakeservreqtypeid=EST.intakeservreqtypeid and INST.activeflag=1 "
      +" where ESA.activeflag=1 and INST.intakeservreqtypeid= $1 order by ESA.description asc";

      return util.executeSecondaryNodeDBQuery(sql, [intakeservicerequesttypeid]).then(data => data)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      };

    Evaluationsourceagency.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Evaluationsourceagency.observe('access', (ctx, next) => util.access(ctx, next));
    Evaluationsourceagency.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};