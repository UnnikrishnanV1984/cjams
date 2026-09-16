'use strict';
const LOGGER = require("log4js").getLogger("tb_provider_complaint_notes");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Tb_provider_complaint_notes) {

    Tb_provider_complaint_notes.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
            }  ],
        returns: {
            type : 'string',
            root : true
        }
    });


   
    Tb_provider_complaint_notes.addupdate = (request,reqctx)=>{
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;

        if(request.provider_complaint_notesid== null || request.provider_complaint_notesid == undefined)
        {
           
            return Tb_provider_complaint_notes.create({
                provider_complaint_contactsid:request.provider_complaint_contactsid,
                complaint_notes_date:request.complaint_notes_date,
                complaint_notes_method_of_contact:request.complaint_notes_method_of_contact,
                complaint_notes_note:request.complaint_notes_note,
                inserted_by: suserid,
                updated_by: suserid
               
    
            }).then(data => {
               return data;
        })
    }
        else
        {
             return Tb_provider_complaint_notes.updateAll(
            {provider_complaint_notesid:request.provider_complaint_notesid},
            {
                provider_complaint_contactsid:request.provider_complaint_contactsid,
                complaint_notes_date:request.complaint_notes_date,
                complaint_notes_method_of_contact:request.complaint_notes_method_of_contact,
                complaint_notes_note:request.complaint_notes_note,
                inserted_by: suserid,
                updated_by: suserid  
                
        }).then(res=>{
            return "Contact Notes Updated Successfully";
        })
        }
        
        
}

  
Tb_provider_complaint_notes.remoteMethod('list', {
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


  
  Tb_provider_complaint_notes.list = (request)=> {

    var Totalcount = 0;
    var pageNumber = request.page;
    var pageLimit = request.limit;
    var provider_complaintid = request.where.provider_complaintid;

    var sql = 'select * from getprovidercomplaintnotesdetails($1,$2,$3)';
    const params = [provider_complaintid,pageNumber, pageLimit];

    return util.executeDBQuery(sql, params)
      .then(data => {
        if (data!=null && data.length > 0) {Totalcount = data[0].totalcount;}
        var result;
        result = {
          'data': data,
          'count': Totalcount
        };
        return result;
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };



  Tb_provider_complaint_notes.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Tb_provider_complaint_notes.observe('access', (ctx, next) => util.access(ctx, next));
  Tb_provider_complaint_notes.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
