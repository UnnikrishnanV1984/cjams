'use strict';
const LOGGER = require("log4js").getLogger("personemail");
const loopback = require('loopback');
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Personemail) {

      Personemail.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Personemail.remoteMethod('personemaildelete', {
        http: { 
                path: '/personemaildelete/:id',
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

    Personemail.remoteMethod('list', {
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

    Personemail.addupdate = function(request, reqctx) { //NOSONAR
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }
      var requestArray = request.addupdateemail;
      var personid = requestArray[0].personid;
      var securityuserid =(request && request.securityuserid?request.securityuserid: _securityusersid);
      var sql = 'select * from addupdateemail( $1, $2, $3)';
      return util.executeDBQuery(sql, [personid, JSON.stringify(requestArray), securityuserid]).then(function(data){
      return data[0];
    })
    .then(async (resp) =>{
      const sql1 = 'SELECT * from sp_get_person_mdm_email($1)';
      return util.executeDBQuery(sql1, [personid]).then(async data => {
          if(data && data[0]?.emailAddresses?.length>0){
            await app.models.Person.addPersonToMDM(data, _securityusersid, 'mdm_addupdate_email');
          }
          return resp;
      }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

    Personemail.personemaildelete = (id) => {
    var sql = 'update personemail set activeflag = 0 WHERE personemailid =\''+id+'\'';
      return util.executeDBQuery(sql, [])
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    
    Personemail.list = request => {
      let gPersonEdn = [];
      const personid  = request.where.personid;
      return Personemail.find({
          where: {personid: personid},
          fields: {personemailid: true, personid: true, personemailtypekey: true, email: true,startdate: true,enddate: true, commentsemail:true}
      })
      .then(data => {
          gPersonEdn = JSON.parse(JSON.stringify(data));
          return Promise.all(gPersonEdn);
      })
      .then(data => data)
      .catch(err => util.logError(err));
    };

  Personemail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Personemail.observe('access', (ctx, next) => util.access(ctx, next));
  Personemail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};