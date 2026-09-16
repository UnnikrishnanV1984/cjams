'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestevaluationconfig");
const loopback = require('loopback');
let app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestevaluationconfig) {

    Intakeservicerequestevaluationconfig.remoteMethod('addupdate', {
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

    Intakeservicerequestevaluationconfig.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
        if(reqctx?.req?.headers?.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }
        const securityuserid = (request.securityuserid ? request.securityuserid : _securityusersid);

        let prs=[];
        var allegationidobj="";

        const sql = "update intakeservicerequestevaluationconfig set activeflag=0 where intakeservicerequestevaluationid=$1";
        return util.executeDBQuery(sql, [request.intakeservicerequestevaluationid]).then(res =>{

         prs = request.offences.map(offence=> {
             allegationidobj=offence.allegationid;
             LOGGER.debug("allegationidobj :: ",allegationidobj);
             LOGGER.debug("intakeservicerequestevaluationid :: ",request.intakeservicerequestevaluationid);
             const offencesql = "select * from editallegationoffence($1,$2,$3)";
             return util.executeDBQuery(offencesql, [request.intakeservicerequestevaluationid,allegationidobj,securityuserid])
              })
          return Promise.all(prs)

          })
          .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });

    };

    Intakeservicerequestevaluationconfig.remoteMethod('listDeactivatedOffence', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            path: '/listDeactivatedOffence',
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });

    Intakeservicerequestevaluationconfig.listDeactivatedOffence = function(request){
        const skip = (request.page - 1) * request.limit;
        const limit = request.limit;
        var sql = "select distinct INEss.allegationid, count(1) over() as totalcount, INEss.intakeservicerequestevaluationid ,AG.name ,INEss.offenceaddedtype from intakeservicerequestevaluationconfig INEss "
         +" join allegation AG on AG.allegationid=INEss.allegationid and AG.activeflag=1 "
         +" where  INEss.intakeservicerequestevaluationid = $1"
         +" and INEss.activeflag=0  group by  INEss.allegationid,INEss.intakeservicerequestevaluationid ,AG.name ,INEss.offenceaddedtype limit $3 offset $2";
    return util.executeDBQuery(sql, [request.where.intakeservicerequestevaluationid,skip,limit]).then(res =>{
        return res
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    }

    Intakeservicerequestevaluationconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestevaluationconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestevaluationconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
