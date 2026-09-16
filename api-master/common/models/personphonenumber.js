'use strict';
const LOGGER = require("log4js").getLogger("personphonenumber");
const loopback = require('loopback');
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Personphonenumber) {

    Personphonenumber.remoteMethod (
        'addupdatephonenumber',
       {
         http: {
             path: '/addupdatephonenumber',
             verb: 'post'
         },
         accepts: [{
             arg: 'data',
             type: 'Object',
             http: {
               source: 'body'
             }
         }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
         returns: {
             arg: 'data',
             type: 'Object'
         }
        });

    Personphonenumber.remoteMethod('personphonenumberdelete', {
        http: { 
                path: '/personphonenumberdelete/:id',
                verb: 'delete'
              },
		accepts:
			  {
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			  },
        returns: 
             {
			    type: 'Object',
			    root: true
		     }
	});
	
	Personphonenumber.remoteMethod('list', {
        http: {
              path: '/list',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
	});

  Personphonenumber.addupdatephonenumber = function (request, reqctx) { // NOSONAR
    let _securityusersid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
      _securityusersid = reqctx.req.headers.securityusersid;
    }
    var requestArray = request.addupdatephonenumber;
    var personid = requestArray[0].personid;
    var securityuserid = (request && request.securityuserid ? request.securityuserid : _securityusersid);
    var sql = 'select * from addupdatephonenumber( $1, $2, $3)';
    return util.executeDBQuery(sql, [personid, JSON.stringify(requestArray), securityuserid]).then(data => {
      return data[0];
    }).then(resp => {
      var sql1 = 'SELECT * from sp_get_person_mdm_phone($1)';
      return util.executeDBQuery(sql1, [personid]).then(async data => {
        if(data && data[0]?.phones?.length>0){
          await app.models.Person.addPersonToMDM(data, _securityusersid, 'mdm_addupdate_phone');
        }
        return resp;
      }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    }).then(function (value) {
      return value;
    }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

    Personphonenumber.personphonenumberdelete = (id) => {
		var sql = 'update personphonenumber set activeflag = 0 WHERE personphonenumberid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};
	   
	Personphonenumber.list = request => {
        let gPersonEdn = [];
        const personid  = request.where.personid;
        return Personphonenumber.find({
            where: {personid: personid},
            fields: {personphonenumberid: true, personid: true, personphonetypekey: true, phonenumber: true, phoneextension: true,startdate: true,enddate: true, isprimary: true,commentsphone:true},
            order: 'startdate desc'
        })
        .then(data => {
            gPersonEdn = JSON.parse(JSON.stringify(data));
            LOGGER.debug(gPersonEdn);
            return Promise.all(gPersonEdn);
        })
        .then(data => data)
        .catch(err => util.logError(err));
	};

	Personphonenumber.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Personphonenumber.observe('access', (ctx, next) => util.access(ctx, next));
   	Personphonenumber.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};