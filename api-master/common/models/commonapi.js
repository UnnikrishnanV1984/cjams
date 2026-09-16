'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
const LOGGER = require("log4js").getLogger("Commonapi");

module.exports = function(Commonapi) {

    Commonapi.remoteMethod('addupdateexternalapilogs', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });

    Commonapi.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Commonapi.observe('access', (ctx, next) => util.access(ctx, next));
    Commonapi.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}

module.exports.addupdateexternalapilogs = async (request) => {
     const sql = `select * from  cjams.addupdateexternalapilogs($1, $2, $3, $4, $5)`;
     const resp = await util.executeDBQuery(sql, [request.details,request.request,request.response,request.resstatus,request.status])
      .then(data => {
        if (data.length>0) {
            if(data[0].addupdateexternalapilogs!=null && data[0].addupdateexternalapilogs.length>0) {
                var result;
                result =  data[0].addupdateexternalapilogs[0].v_externalapilogsid;
                return result;
            }
        }
      })
      .catch(err => {
        LOGGER.error('>>>>>>commonapi/addupdateexternalapilogs>>>Error ',err);
        return util.logError(err);
      });
    LOGGER.info(resp);
    return resp;
};

module.exports.addupdateemaillog= async (request) => {
     const sql = `select * from  cjams.addupdateemaillog($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)`;
     const resp = await util.executeDBQuery(sql, [request.objecttype, request.objectid, request.toemail, request.body, request.response, request.sub, request.securityusersid,request.addorupdate ,request.emaillogsid,request.responsestatus])
      .then(data => {
          if (data.length>0) {
          if(data[0].addupdateemaillog!=null && data[0].addupdateemaillog.length>0) {
          var result;
            result =  data[0].addupdateemaillog[0].v_output;
          return result;
          }
          }
      })
      .catch(err => {
          LOGGER.error('>>>>>>commonapi/addupdateemaillog>>>Error ',err);
          return err;
      });
     LOGGER.info(resp);
     return resp;
};






  
