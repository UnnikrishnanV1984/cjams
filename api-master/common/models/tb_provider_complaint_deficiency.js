'use strict';
const LOGGER = require("log4js").getLogger("tb_provider_complaint_deficiency");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Tb_provider_complaint_deficiency) {

    Tb_provider_complaint_deficiency.remoteMethod('addupdate', {
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


   
    Tb_provider_complaint_deficiency.addupdate = (request,reqctx)=>
    {   let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      } 
      var securityusersid= (request && request.securityuserid?request.securityuserid: suserid);

        var deficiencyid = request.tb_provider_complaint_deficiencyid;
        if (deficiencyid == undefined || deficiencyid == '' || deficiencyid == null){
               request.inserted_by = securityusersid;
             request.updated_by = securityusersid;

        return Tb_provider_complaint_deficiency.create(request).then(data => {

            return data;
		}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }else if (deficiencyid != undefined && deficiencyid != '' && deficiencyid != null){
            request.updated_by = securityusersid;
            return Tb_provider_complaint_deficiency.updateAll({receipt_id:request.tb_provider_complaint_deficiencyid}, request).then(data => {
                return data;
            }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

        }
        
        
}

  
Tb_provider_complaint_deficiency.remoteMethod('list', {
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


  
  Tb_provider_complaint_deficiency.list = (request)=> {

    var Totalcount = 0;
    var pageNumber = request.page;
    var pageLimit = request.limit;
    var provider_complaintid = request.where.provider_complaintid;

    var sql = 'select * from getprovidercomplaintdeficiencydetails($1,$2,$3)';
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

  Tb_provider_complaint_deficiency.remoteMethod('deletedeficiency', {
    http: {
            path: '/deletedeficiency',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} ],
    returns: {
        type : 'string',
        root : true
    }
});

Tb_provider_complaint_deficiency.deletedeficiency = function(request)
{  
    var deficiencyid = request.tb_provider_complaint_deficiencyid;
    LOGGER.debug(deficiencyid)
 
        return Tb_provider_complaint_deficiency.updateAll({tb_provider_complaint_deficiencyid:deficiencyid}, {activeflag:0}).then(data => {
            return data;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    
  
};


Tb_provider_complaint_deficiency.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Tb_provider_complaint_deficiency.observe('access', (ctx, next) => util.access(ctx, next));
Tb_provider_complaint_deficiency.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
