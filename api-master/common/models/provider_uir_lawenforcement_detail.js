"use strict";
const LOGGER = require("log4js").getLogger("provider_uir_lawenforcement_detail");
const util = require("../utils/utils");
var app = require("../../server/server");

module.exports = function (provider_uir_lawenforcement_detail) {
  provider_uir_lawenforcement_detail.remoteMethod("addupdate", {
    http: {
      path: "/addupdate",
      verb: "post"
    },
    accepts: [{ arg: "data", type: "object", http: { source: "body" } }
    ,{
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
    } ],
    returns: {
      type: "string",
      root: true
    }
  });

  provider_uir_lawenforcement_detail.addupdate = (request,reqctx) => {
    const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
      return app.models.provider_uir_lawenforcement_detail.find({
        where: {
          provider_uir_id: request.provider_uir_id
        }
      }).then(data => {
        if (data.length == 0) {
          return app.models.provider_uir_lawenforcement_detail.create({
            provider_uir_id: request.provider_uir_id,
            report_number: request.report_number,
            date: request.date,
            time: request.time,
            contact_first_name: request.contact_first_name,
					  contact_last_name: request.contact_last_name,
					  phone_no: request.phone_no,
            uir_no: request.uir_no,
            active_flag: 1,
            insertedby: suserid,
            updatedby: suserid
          }).then(res => {
            return res;
          });
        } else {
          return app.models.provider_uir_lawenforcement_detail.updateAll(
            { provider_uir_id: request.provider_uir_id },
            {
              report_number: request.report_number,
              date: request.date,
              time: request.time,
              contact_first_name: request.contact_first_name,
              contact_last_name: request.contact_last_name,
              phone_no: request.phone_no,
              uir_no: request.uir_no,
              updatedby: suserid
            }
          ).then(result => {
            return result;
          });
        }
      });
    
  };

  provider_uir_lawenforcement_detail.remoteMethod("list", {
    accepts: {
      arg: "filter",
      type: "Object",
      http: {
        source: "query"
      },
      required: true
    },
    http: {
      path: "/list",
      verb: "get"
    },
    returns: {
      type: "string",
      root: true
    }
  });

  provider_uir_lawenforcement_detail.list = function (request) {
    var sql = "select * from getprovider_uir_lawenforcement_detail($1)";

    return util.executeDBQuery(sql, [request.where.provider_uir_id])
      .then(data => {
        if (data) {
          return data[0].getprovider_uir_lawenforcement_detail;
        } else {
          return data;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  provider_uir_lawenforcement_detail.observe("before save", (ctx, next) =>
    util.beforesave(ctx, next)
  );
  provider_uir_lawenforcement_detail.observe("access", (ctx, next) =>
    util.access(ctx, next)
  );
  provider_uir_lawenforcement_detail.beforeRemote("*", (ctx, data, next) =>
    util.beforeremote(ctx, next)
  );
};
