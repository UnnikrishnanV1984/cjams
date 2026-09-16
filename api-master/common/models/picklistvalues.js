'use strict';
const LOGGER = require("log4js").getLogger("picklistvalues");
var server = require('../../server/server');
const app = require('../../server/server');
const util = require('../utils/utils');


var Frequency;
var Duration;

// Every picklist endpoint here does the same thing: run one query and return its
// rows untouched, logging locally on success and handing failures to the central
// logger. Shared so the identical block is not repeated per endpoint.
const runPicklistQuery = (dataQuery, params) => util.executeDBQuery(dataQuery, params)
  .then(result => {
    LOGGER.debug('success');
    LOGGER.debug(result, 'result');
    return result;
  })
  .catch(err => util.logError(err));

module.exports = function (Picklistvalues) {
  Picklistvalues.findByCategory = (picklistTypeId) => {
    LOGGER.debug('hello');
    const dataQuery = 'SELECT get_picklist_values($1)';
    return runPicklistQuery(dataQuery, [picklistTypeId]);
  };

  Picklistvalues.remoteMethod('findByCategory', {
    http: {
      path: '/category/:picklistTypeId',
      verb: 'get'
    },
    accepts: {
      arg: 'picklistTypeId',
      type: 'number',
      http: {
        source: 'path',
      },
      required: true
    },
    returns: {
      arg: 'UserToken',
      type: 'Object'
    }
  });

  //service end reason
  //
  //
  Picklistvalues.serviceEndReason = () => {
    const dataQuery = 'SELECT * FROM get_serviceend_resaon()';
    return runPicklistQuery(dataQuery, []);
  };

  Picklistvalues.remoteMethod('serviceEndReason', {
    http: {
      path: '/serviceEndReason',
      verb: 'get'
    },
    returns: {
      arg: 'UserToken',
      type: 'Object'
    }
  });

//reason service not received
//
//
Picklistvalues.reasonServiceNotReceived = () => {
  const dataQuery = 'select * from get_servicenot_received()';
  return runPicklistQuery(dataQuery, []);
};

Picklistvalues.remoteMethod('reasonServiceNotReceived', {
  http: {
    path: '/reasonServiceNotReceiveds',
    verb: 'get'
  },
  returns: {
    arg: 'UserToken',
    type: 'Object'
  }
});


//frequency
//
//
  Picklistvalues.frequencyList = () => {
    const dataQuery = 'SELECT * from get_picklist_values($1)';
    return runPicklistQuery(dataQuery, [1398]);
  };

  Picklistvalues.remoteMethod('frequencyList', {
    http: {
      path: '/frequencyList',
      verb: 'get'
    },
    returns: {
      arg: 'UserToken',
      type: 'Object'
    }
  });


  //duration
  //
  //

  Picklistvalues.durationList = () => {
    const dataQuery = 'SELECT * from get_picklist_values($1)';
    return runPicklistQuery(dataQuery, [1397]);
  };

  Picklistvalues.remoteMethod('durationList', {
    http: {
      path: '/durationList',
      verb: 'get'
    },
    returns: {
      arg: 'UserToken',
      type: 'Object'
    }
  }); 

  //IncomePickList Values for dropdown 
  Picklistvalues.incomepicklistvalues = () => {
    const dataQuery = "select income_source_tx as value_tx , income_source_id as picklist_value_cd, exempt_sw from tb_client_income_source where delete_sw = 'N' order by income_source_tx";
    return runPicklistQuery(dataQuery, []);
  };

  Picklistvalues.remoteMethod('incomepicklistvalues', {
    http: {
      path: '/incomepicklistvalues',
      verb: 'get'
    },
    returns: {
      arg: 'UserToken',
      type: 'Object'
    }
  });


  Picklistvalues.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Picklistvalues.observe('access', (ctx, next) => util.access(ctx, next));
  Picklistvalues.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
