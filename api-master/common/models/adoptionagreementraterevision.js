  'use strict';
  const LOGGER = require("log4js").getLogger("adoptionagreementraterevision");
  const util = require('../utils/utils');
  var app = require('../../server/server');

  module.exports = function(Adoptionagreementraterevision) {

    Adoptionagreementraterevision.remoteMethod('createraterevision', {
      http: {
        path: '/createraterevision',
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

    Adoptionagreementraterevision.createraterevision = async (request, reqctx) => {
      const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid
      var securityusersid = _securityusersid;
      var now = new Date();
      request.insertedby = securityusersid;
      request.updatedby = securityusersid;
      request.insertedon = now;
      request.updatedon = now;
      request.status = 'Review';

      if (!request.adoptionagreementrateid) {
        var genid = "select * from gen_random_uuid()"; //@TM: use generated rate id if unavailable
        const gen_random_uuid = await util.executeDBQuery(genid, [])
          .then(rateid => {
            var generatedId = JSON.parse(JSON.stringify(rateid));
            return generatedId[0].gen_random_uuid;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
        request.adoptionagreementrateid = gen_random_uuid;
      }

      if (request.adoptionagreementrateid) {
        // De-activate any existing review/incomplete records
        var revision = "update adoptionagreementraterevision"
        +" set activeflag = 0"
        +" where adoptionagreementrateid = \'"+request.adoptionagreementrateid+"\'"
        +" and activeflag = 1"
        +" and (approvalstatustypekey = '3045' or approvalstatustypekey ='3046' or approvalstatustypekey is null)";
        return util.executeDBQuery(revision, [])
        .then(() => "success")
        .then( res => {
          if (res === "success") {
            // Create revision - Rate record should be created only after approval
            return Adoptionagreementraterevision.create(request).then(data => {
              return data;
            });
          } else {
            return Promise.resolve('Unable to create revision!');
          }
        }).catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
      }
    }

    Adoptionagreementraterevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionagreementraterevision.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionagreementraterevision.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
  }    
