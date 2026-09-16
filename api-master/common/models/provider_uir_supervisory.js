'use strict';
const LOGGER = require("log4js").getLogger("provider_uir_supervisory");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Provider_uir_supervisory) {

    Provider_uir_supervisory.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
            } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    
  Provider_uir_supervisory.addupdate = (request,reqctx) => {
    const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
    var resprovideruirid = null;

    if (request.provider_uir_supervisory_id === null || request.provider_uir_supervisory_id === undefined) {
      if (request.provider_uir_id === null && request.provider_uir_id === undefined) {
        return app.models.Provider_uir.create(
          {
            uir_no: request.uir_no,
            provider_id: request.provider_id,
            inserted_by: suserid,
            updated_by: suserid
          })
          .then(data => {
            resprovideruirid = data.provider_uir_id;
            return Provider_uir_supervisory.create({
              provider_uir_id: resprovideruirid,
              supervisor_comments: request.supervisor_comments,
              supervisor_name: request.supervisor_name,
              supervisor_signdate: request.supervisor_signdate,
              is_section_filledout: request.is_section_filledout,
              is_supervisor_comments: request.is_supervisor_comments,
              is_youth_witness: request.is_youth_witness,
              is_notification: request.is_notification,
              is_nurses_reports: request.is_nurses_reports,
              is_signed_dates: request.is_signed_dates,
              is_addition_support: request.is_addition_support,
              is_check_spelling: request.is_check_spelling,
              is_comments_location: request.is_comments_location,
              is_incident_report: request.is_incident_report,
              other_section_filledout: request.other_section_filledout,
              other_supervisor_comments: request.other_supervisor_comments,
              other_youth_witness: request.other_youth_witness,
              other_notification: request.other_notification,
              other_nurses_reports: request.other_nurses_reports,
              other_signed_dates: request.other_signed_dates,
              other_check_spelling: request.other_check_spelling,
              other_comments_location: request.other_comments_location,
              other_addition_support: request.other_addition_support,
              other_incident_report: request.other_incident_report,
              completed_by_name: request.completed_by_name,
              completed_by_date: request.completed_by_date,
              inserted_by: suserid,
              updated_by: suserid
            }).then(data1 => {
              return data1;
            })
          })
      }
      else {
        return Provider_uir_supervisory.create({
          provider_uir_id: request.provider_uir_id,
          supervisor_comments: request.supervisor_comments,
          supervisor_name: request.supervisor_name,
          supervisor_signdate: request.supervisor_signdate,
          is_section_filledout: request.is_section_filledout,
          is_supervisor_comments: request.is_supervisor_comments,
          is_youth_witness: request.is_youth_witness,
          is_notification: request.is_notification,
          is_nurses_reports: request.is_nurses_reports,
          is_signed_dates: request.is_signed_dates,
          is_addition_support: request.is_addition_support,
          is_check_spelling: request.is_check_spelling,
          is_comments_location: request.is_comments_location,
          is_incident_report: request.is_incident_report,
          other_section_filledout: request.other_section_filledout,
          other_supervisor_comments: request.other_supervisor_comments,
          other_youth_witness: request.other_youth_witness,
          other_notification: request.other_notification,
          other_nurses_reports: request.other_nurses_reports,
          other_signed_dates: request.other_signed_dates,
          other_check_spelling: request.other_check_spelling,
          other_comments_location: request.other_comments_location,
          other_addition_support: request.other_addition_support,
          other_incident_report: request.other_incident_report,
          completed_by_name: request.completed_by_name,
          completed_by_date: request.completed_by_date,
          inserted_by: suserid,
          updated_by: suserid
        }).then(data => {
          return data;
        })
      }
    }
    else {
      return Provider_uir_supervisory.updateAll(
        { provider_uir_supervisory_id: request.provider_uir_supervisory_id },
        {
          provider_uir_id: request.provider_uir_id,
          supervisor_comments: request.supervisor_comments,
          supervisor_name: request.supervisor_name,
          supervisor_signdate: request.supervisor_signdate,
          is_section_filledout: request.is_section_filledout,
          is_supervisor_comments: request.is_supervisor_comments,
          is_youth_witness: request.is_youth_witness,
          is_notification: request.is_notification,
          is_nurses_reports: request.is_nurses_reports,
          is_signed_dates: request.is_signed_dates,
          is_addition_support: request.is_addition_support,
          is_check_spelling: request.is_check_spelling,
          is_comments_location: request.is_comments_location,
          is_incident_report: request.is_incident_report,
          other_section_filledout: request.other_section_filledout,
          other_supervisor_comments: request.other_supervisor_comments,
          other_youth_witness: request.other_youth_witness,
          other_notification: request.other_notification,
          other_nurses_reports: request.other_nurses_reports,
          other_signed_dates: request.other_signed_dates,
          other_check_spelling: request.other_check_spelling,
          other_comments_location: request.other_comments_location,
          other_addition_support: request.other_addition_support,
          other_incident_report: request.other_incident_report,
          completed_by_name: request.completed_by_name,
          completed_by_date: request.completed_by_date,
          inserted_by: suserid,
          updated_by: suserid
        }).then(res => {
          return "UIR Updated Successfully";
        })
    }
  }

    
    Provider_uir_supervisory.remoteMethod('list', {
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


  
  Provider_uir_supervisory.list = function (request) {

    var sql = 'select * from getprovidersupervisory($1)';

    return util.executeDBQuery(sql, [request.where.provider_uir_id])
      .then(data => {
        if(data){
          return data[0].getprovidersupervisory;
        }else {
          return data;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };

  


  Provider_uir_supervisory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Provider_uir_supervisory.observe('access', (ctx, next) => util.access(ctx, next));
  Provider_uir_supervisory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
    };
    
