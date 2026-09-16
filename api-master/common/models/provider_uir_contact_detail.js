"use strict";
const util = require("../utils/utils");
var app = require("../../server/server");

module.exports = function (Provider_uir_contact_detail) {
  Provider_uir_contact_detail.remoteMethod("addupdate", {
    http: {
      path: "/addupdate",
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
  
  Provider_uir_contact_detail.remoteMethod(
    'list', {
        http: {
            path: '/list',
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
    }
);

  Provider_uir_contact_detail.addupdate = function(request,reqctx) {
    let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
      // return app.models.Provider_uir_contact_detail.find({
      //   where: {
      //     provider_uir_contact_detail_id: request.provider_uir_contact_detail_id
      //   }
      // }).then(data => {
      //   if (data.length == 0) {
          return app.models.Provider_uir_contact_detail.create({
            provider_uir_id: request.provider_uir_id,
            firstname: request.first_name,
            lastname: request.last_name,
            phonenumber: request.phone_no,
            email: request.email,
            uir_no: request.uir_no,
            activeflag: 1,
            insertedby: (request && request.securityuserid ? request.securityuserid : suserid),
            updatedby: (request && request.securityuserid ? request.securityuserid : suserid)
          }).then(res => {
            return res;
          }).catch(err => util.logError(err));
      //   } else {
      //     return app.models.Provider_uir_contact_detail.updateAll(
      //       { provider_uir_id: request.provider_uir_id },
      //       {
      //         firstname: request.first_name,
      //         lastname: request.last_name,
      //         phonenumber: request.phone_no,
      //         email: request.email,
      //         uir_no: request.uir_no,
      //         updatedby: (request && request.securityuserid?request.securityuserid: app.currentUser.securityusersid)
      //       }
      //     ).then(result => {
      //       return result;
      //     }).catch(err => util.logError(err));
      //   }
      // });
    
  };

  Provider_uir_contact_detail.list = request =>{
    const sql = 'select * from provider_uir_contact_detail($1)';
    return util.executeDBQuery(sql, [request.where.provider_uir_id])
       .then(resp => resp)
       .catch(err => util.logError(err));
}

  Provider_uir_contact_detail.observe("before save", (ctx, next) =>
    util.beforesave(ctx, next)
  );
  Provider_uir_contact_detail.observe("access", (ctx, next) =>
    util.access(ctx, next)
  );
  Provider_uir_contact_detail.beforeRemote("*", (ctx, data, next) =>
    util.beforeremote(ctx, next)
  );
};
