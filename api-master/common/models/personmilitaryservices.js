'use strict';
const LOGGER = require("log4js").getLogger("personmilitaryservices");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Personmilitaryservices) {

  Personmilitaryservices.remoteMethod('personmilitaryservicesdelete', {
    http: {
      "path": "/personmilitaryservicesdelete/:id",
      "verb": "delete"
    },
    accepts: {
      "arg": "id",
      "type": "string",
      "required": true,
      "http": {
        "source": "path"
      }
    },
    returns: {
      "type": "Object",
      "root": true
    }
  });

  Personmilitaryservices.personmilitaryservicesdelete = (id) => {
    var sql = 'update personmilitaryservices set activeflag = 0 WHERE personmilitaryserviceid =\'' + id + '\'';
    return util.executeDBQuery(sql, [])
    .then(data => {
      return data;
    })
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });
  };



  Personmilitaryservices.remoteMethod('addupdate', {
    http: {
      path: '/addupdate',
      verb: 'post'
    },
    accepts: [{
      arg: 'data',
      type: 'object',
      http: {
        source: 'body'
      }
    }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    returns: {
      type: 'string',
      root: true
    }
  });

  Personmilitaryservices.addupdate = function (request, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    var securityuserid = (request && request.securityuserid?request.securityuserid: _securityusersid);
    var mil = request.military;
    var personid = request.personid;

    var sql = "select * from addupdatemilitary($1,$2,$3)"
    return util.executeDBQuery(sql, [personid, JSON.stringify(mil), securityuserid])
    .then(res => {
      return res
    })
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });
  };

  Personmilitaryservices.remoteMethod('getpersonmilitaryservices', {
    http: {
      path: '/militarylist',
      verb: 'get'
    },
    accepts: [{
      arg: 'filter',
      type: 'object',
      http: {
        source: 'query'
      }
    }],
    returns: {
      type: 'object',
      root: true
    }
  });

   Personmilitaryservices.getpersonmilitaryservices = function (request) {
    const personid = request.where.personid;
      var sql = 'select * from getmilitarydetails($1)';
      return util.executeSecondaryNodeDBQuery(sql, [personid])
    .then(data => {
          return data[0];
    }).then(function (value) {
      return value;
    }).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  };
};