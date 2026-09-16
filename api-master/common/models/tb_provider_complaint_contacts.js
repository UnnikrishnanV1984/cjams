'use strict';
const LOGGER = require("log4js").getLogger("tb_provider_complaint_contacts");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Tb_provider_complaint_contacts) {

    Tb_provider_complaint_contacts.remoteMethod('addupdate', {
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


   
    Tb_provider_complaint_contacts.addupdate = (request,reqctx)=>
    {  let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      }
        if(request.provider_complaint_contactsid== null || request.provider_complaint_contactsid == undefined)
        {
           
            return Tb_provider_complaint_contacts.create({
                provider_complaintid:request.provider_complaintid,
                complaint_contacts_name:request.complaint_contacts_name,
                complaint_contacts_source:request.complaint_contacts_source,
                complainant_contacts_phone:request.complainant_contacts_phone,
                inserted_by:(request && request.securityusersid? request.securityusersid: suserid),
                updated_by:(request && request.securityusersid? request.securityusersid: suserid)
               
    
            }).then(data => {
               return data;
        })
    }
        else
        {
             return Tb_provider_complaint_contacts.updateAll(
            {provider_complaint_contactsid:request.provider_complaint_contactsid},
            {
                complaint_contacts_name:request.complaint_contacts_name,
                complaint_contacts_source:request.complaint_contacts_source,
                complainant_contacts_phone:request.complainant_contacts_phone,
                updated_by:(request && request.securityuserid?request.securityuserid: suserid)    
                
        }).then(res=>{
            return "Contact Updated Successfully";
        })
        }
        
        
}

  
Tb_provider_complaint_contacts.remoteMethod('list', {
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


  
  Tb_provider_complaint_contacts.list = (request)=> {

    var Totalcount = 0;
    var pageNumber = request.page;
    var pageLimit = request.limit;
    var provider_complaintid = request.where.provider_complaintid;
 
    var sql = 'select * from getprovidercomplaintcotactdetails($1,$2,$3)';
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

  Tb_provider_complaint_contacts.remoteMethod('deletecontact', {
    http: {
            path: '/deletecontact',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} ],
    returns: {
        type : 'string',
        root : true
    }
});
Tb_provider_complaint_contacts.remoteMethod('deletenotes', {
  http: {
          path: '/deletenotes',
          verb: 'post'
  },
  accepts : [ {arg : 'data',type : 'object',
      http : {source : 'body'}} ],
  returns: {
      type : 'string',
      root : true
  }
});

Tb_provider_complaint_contacts.deletecontact = function(request)
{  
    var contactsid = request.provider_complaint_contactsid;
    LOGGER.debug(contactsid)
 
        return Tb_provider_complaint_contacts.updateAll({provider_complaint_contactsid:contactsid}, {activeflag:0}).then(data => {
            return data;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    
  
};
Tb_provider_complaint_contacts.deletenotes = function(request)
{  
    var notesid = request.provider_complaint_notesid;
    LOGGER.debug(notesid)
 
        return app.models.Tb_provider_complaint_notes.updateAll({provider_complaint_notesid:notesid}, {activeflag:0}).then(data => {
            return data;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    
  
};



Tb_provider_complaint_contacts.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Tb_provider_complaint_contacts.observe('access', (ctx, next) => util.access(ctx, next));
Tb_provider_complaint_contacts.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
