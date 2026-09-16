"use strict";
const LOGGER = require("log4js").getLogger("provider_uir_youth_detail");
const util = require("../utils/utils");
var app = require("../../server/server");

module.exports = function(Provider_uir_youth_detail) {
  Provider_uir_youth_detail.remoteMethod("assignyouth", {
    http: {
      path: "/assignyouth",
      verb: "post"
    },
    accepts: [{ arg: "data", type: "object", http: { source: "body" } },{
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
    }],
    returns: {
      type: "string",
      root: true
    }
  });

  Provider_uir_youth_detail.assignyouth = (request,reqctx) => {
    let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
    var youthpromises = [];
    var youthids = request.youth;
    youthids.map(element => {
    var youthpromise;
      youthpromise = new Promise((resolve, reject) => {
        Provider_uir_youth_detail.create(
          {
            provider_uir_id: request.provider_uir_id,
            uir_no: request.uir_no,
            provider_uir_actor_id: element.provider_youth_id,
            insertedby: request && request.securityuserid?request.securityuserid: suserid,
            updatedby: request && request.securityuserid?request.securityuserid: suserid,
            provider_id: request.object_id,
            activeflag: 1
          },
          (err, resp) => {
            err ? reject(err) : resolve(resp);
          }
        );
      });
      youthpromises.push(youthpromise);
    });
    return Promise.all(youthpromises).then(response => {
      return response;
    });
  };

  Provider_uir_youth_detail.remoteMethod("getassignedyouth", {
    accepts: {
      arg: "filter",
      type: "Object",
      http: {
        source: "query"
      },
      required: true
    },
    http: {
      path: "/getassignedyouth",
      verb: "get"
    },
    returns: {
      type: "string",
      root: true
    }
  });

  Provider_uir_youth_detail.getassignedyouth = function(request) {
    var sql = `select * from provider_uir_youth_detail yd join provider_uir_actor_detail  ad
    on yd.provider_uir_actor_id ::uuid=ad.provider_uir_actor_detail_id
    where uir_no=$1`
    var params = [request.where.uir_no];

    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Provider_uir_youth_detail.remoteMethod("getyouthlistbyprovider", {
    accepts: {
      arg: "filter",
      type: "Object",
      http: {
        source: "query"
      },
      required: true
    },
    http: {
      path: "/getyouthlistbyprovider",
      verb: "get"
    },
    returns: {
      type: "string",
      root: true
    }
  });

  Provider_uir_youth_detail.getyouthlistbyprovider = function(request) {
    var sql = `select * from provider_uir_actor_detail where provider_id=$1`
    var params = [request.where.object_id];

    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Provider_uir_youth_detail.observe("before save", (ctx, next) =>
    util.beforesave(ctx, next)
  );
  Provider_uir_youth_detail.observe("access", (ctx, next) =>
    util.access(ctx, next)
  );
  Provider_uir_youth_detail.beforeRemote("*", (ctx, data, next) =>
    util.beforeremote(ctx, next)
  );
};
