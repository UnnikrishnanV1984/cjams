'use strict';
const LOGGER = require("log4js").getLogger("provider_uir_notification");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Provider_uir_notification) {

    Provider_uir_notification.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ,{
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
            } ],
        returns: {
            type : 'string',
            root : true
        }
    });


   
  Provider_uir_notification.addupdate = (request,reqctx) => {
    const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
    const prs = [];
    var noticationinformation = request.noticationinformation;
    var resprovideruirid = null;
    if (request.provider_uir_id === null && request.provider_uir_id === undefined) {
      return app.models.Provider_uir.create(
        {
          uir_no: request.uir_no,
          notifiy_is_attach: request.notifiy_is_attach,
          notifiy_attach_other: request.notifiy_attach_other,
          notification_comments: request.notification_comments,
          notifiy_staff_member: request.notifiy_staff_member,
          notifiy_signdatetime: request.notifiy_signdatetime,
          inserted_by: suserid,
          updated_by: suserid
        }
      ).then(data => {
        resprovideruirid = data.provider_uir_id;
        if (Array.isArray(noticationinformation)) {
          noticationinformation.forEach(noticationinformation1 => {
            prs.push(
              app.models.Provider_uir_notification.create({
                provider_uir_id: resprovideruirid,
                notification_type: noticationinformation1.notification_type,
                services_name: noticationinformation1.services_name,
                notifcation_name: noticationinformation1.notifcation_name,
                notifcation_datetime: noticationinformation1.notifcation_datetime,
                notifcation_received: noticationinformation1.notifcation_received,
                notifcation_comments: noticationinformation1.notifcation_comments,
                method_type: noticationinformation1.method_type,
                insertedby: suserid,
                updatedby: suserid
              })
            )
          });
        }
        return Promise.all(prs);

      })

    }
    else {
      prs.push(app.models.Provider_uir.updateAll(
        { provider_uir_id: request.provider_uir_id },
        {
          notifiy_is_attach: request.notifiy_is_attach,
          notifiy_attach_other: request.notifiy_attach_other,
          notification_comments: request.notification_comments,
          notifiy_staff_member: request.notifiy_staff_member,
          notifiy_signdatetime: request.notifiy_signdatetime
        }
      ));
      prs.push(app.models.Provider_uir_notification.updateAll(
        { provider_uir_id: request.provider_uir_id },
        { active_flag: 0 }
      ));

      if (Array.isArray(noticationinformation)) {
        noticationinformation.forEach(noticationinformation2 => {
          prs.push(
            app.models.Provider_uir_notification.create({
              provider_uir_id: request.provider_uir_id,
              notification_type: noticationinformation2.notification_type,
              services_name: noticationinformation2.services_name,
              notifcation_name: noticationinformation2.notifcation_name,
              notifcation_datetime: noticationinformation2.notifcation_datetime,
              notifcation_received: noticationinformation2.notifcation_received,
              notifcation_comments: noticationinformation2.notifcation_comments,
              method_type: noticationinformation2.method_type,
              insertedby: suserid,
              updatedby: suserid
            })
          )
        });
      }
      return Promise.all(prs);
    }
  }

Provider_uir_notification.remoteMethod('list', {
    accepts : {
      arg : 'filter',
      type : 'Object',
      http : {
        source : 'query'
      },
      required : true
    },
    http : {
      path: '/list',
      verb : 'get'
    },
    returns : {
      type : 'string',
      root : true
    }
  });


  
  Provider_uir_notification.list = function (request) {

    var sql = 'select * from getprovidernotifydetails($1)';

    return util.executeDBQuery(sql, [request.where.provider_uir_id])
      .then(data => {
        if(data){
          return data[0].getprovidernotifydetails;
        }else {
          return data;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };

  

Provider_uir_notification.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Provider_uir_notification.observe('access', (ctx, next) => util.access(ctx, next));
Provider_uir_notification.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
