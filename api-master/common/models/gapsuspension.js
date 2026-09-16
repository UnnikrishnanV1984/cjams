'use strict';
const LOGGER = require("log4js").getLogger("gapsuspension");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Gapsuspension) {

    /**Gapsuspension add */
    Gapsuspension.remoteMethod('add', {
        http: {
                path: '/add',
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
    Gapsuspension.add = function(request, reqctx)
    {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;

        var revisionObj = {};

        if(request.servicecaseid == null && request.servicecaseid == undefined){
          request.servicecaseid = '';
      } 
        if (request.gapsuspensionid == undefined || request.gapsuspensionid == null) {
          
           
    
           
        return Gapsuspension.create({
            gapid:request.gapid,
            suspensionreasontypekey:request.suspensionreasontypekey,
            startdate:request.startdate,
            dateofdeath: request.dateofdeath,
            enddate:request.enddate,
            notes:request.notes,
            isdraft:request.isdraft,
            suspensiondesc:request.suspensiondesc,
            insertedby: _securityusersid,
            updatedby: _securityusersid,
            otherreason:request.otherreason,
            approvalstatustypekey:'3045'
        })
        .then(resp => {
 
            revisionObj.suspensionid=resp.gapsuspensionid;
            revisionObj.guardiansubsidyid=request.gapid;
            revisionObj.transactiondate=request.transactiondate;
            revisionObj.reasontypekey=request.suspensionreasontypekey;
            revisionObj.startdate=request.startdate;
            revisionObj.enddate=request.enddate;
            revisionObj.suspensiondesc=request.suspensiondesc;
            revisionObj.approvalstatustypekey='3045';
            revisionObj.isoriginal=request.isoriginal;
            revisionObj.activeflag=request.activeflag;
            revisionObj.insertedby= _securityusersid;
            app.models.Gapsuspensionrevision.create(revisionObj).then(
              data=>{ 

           
            var status = 15;
            var nofitymsg = 'Guardianship Suspension Submitted for review';
            
            
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
            
         //   return new Promise((resolve, reject) => {
                util.executeDBQuery(sql, [resp.gapsuspensionid,  _securityusersid, 'GASR', status, nofitymsg, '', false, false, false, nofitymsg,'',request.servicecaseid,'',1])
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
           }
          );
          return resp;
        }).catch(err => util.logError(err));
    }
    else
    {
      
        var sql2 = 'UPDATE gapsuspensionrevision SET activeflag=0 WHERE guardiansubsidyid =\''+request.gapid+'\'' ;
            util.executeDBQuery(sql2,[])
            .then(data => {
                LOGGER.info(data);
            })
            .catch(err => {
                LOGGER.error(err);
                throw err;
            })
            revisionObj.suspensionid=request.gapsuspensionid;
            revisionObj.guardiansubsidyid=request.gapid;
            revisionObj.transactiondate=request.transactiondate;
            revisionObj.reasontypekey=request.suspensionreasontypekey;
            revisionObj.startdate=request.startdate;
            revisionObj.enddate=request.enddate;
            revisionObj.suspensiondesc=request.suspensiondesc;
            revisionObj.approvalstatustypekey='3045';
            revisionObj.isoriginal=request.isoriginal;
            revisionObj.activeflag=request.activeflag;
            revisionObj.insertedby= _securityusersid;
            return app.models.Gapsuspensionrevision.create(revisionObj).then(
              resp=>{ 

           
            var status = 15;
            var nofitymsg = 'Guardianship Suspension Submitted for review';
            
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
            
         //   return new Promise((resolve, reject) => {
                return util.executeDBQuery(sql, [request.gapsuspensionid, _securityusersid, 'GASR', status, nofitymsg, '', false, false, false, nofitymsg,'',request.servicecaseid,'',1])
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
           }
          );
         
          
    }
    }
    
    Gapsuspension.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Gapsuspension.observe('access', (ctx, next) => util.access(ctx, next));
    Gapsuspension.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));   
}
