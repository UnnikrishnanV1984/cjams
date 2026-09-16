'use strict';
const LOGGER = require("log4js").getLogger("gapagreementrate");
const util = require('../utils/utils');
var app = require('../../server/server');
const guardianshipmsg= 'Guardianship Agreement Submitted for review';
module.exports = function(Gapagreementrate) {

    Gapagreementrate.remoteMethod('add', {
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

    Gapagreementrate.addrate =(request, _securityusersid)=>{
        var securityusersid =  _securityusersid;
        const prs = [];
        var gapagreementid = request.gapagreementid;
        var gapagreementrateid;
        if(request.servicecaseid == null && request.servicecaseid === undefined){
          request.servicecaseid = '';
       } 
        if(request.gapagreementid !== undefined && request.gapagreementid !== null){
          const gapagreementrate = request.gapagreementrate;
          const response = [];

          if (Array.isArray(gapagreementrate)) {
            var updateGaprateId = null;
            var sqlgapagreement = null;
            if(request.isagreementedit === "yes"){

              updateGaprateId=gapagreementrate[0].editGapAgreementRate;
              sqlgapagreement = 'update gapagreementrate set activeflag = 0, updatedby = $1, updatedon = now() where gapagreementrateid = $2';
              util.executeDBQuery(sqlgapagreement,[securityusersid,updateGaprateId])
              .then(_data => {
                  LOGGER.info(_data);
              })
              .catch(err => {
                  LOGGER.error(err);
                  throw err;
              })
                  gapagreementrate.forEach(element => {
                    var revisionObj = {};
                      element.activeflag = 1;
                      element.insertedby=securityusersid;
                      element.gapagreementid=gapagreementid;
                      response.push(
                          app.models.Gapagreementrate.create(element).then(_data =>
                            {
                              gapagreementrateid=_data.gapagreementrateid;
                              revisionObj.gaprateid=_data.gapagreementrateid;
                              revisionObj.guardiansubsidyid=request.gapid;
                              revisionObj.transactiondate=element.transactiondate;
                              revisionObj.ratestartdate=element.startdate;
                              revisionObj.rateenddate=element.enddate;
                              revisionObj.paymentamt=element.paymentamout;
                              revisionObj.notes=element.comments;
                              revisionObj.activeflag=element.activeflag;
                              revisionObj.insertedby=element.insertedby;
                              revisionObj.providerid=element.providerid;
                              revisionObj.approvalstatustypekey= '3045'; 
                              app.models.Gapratesrevision.create(revisionObj);	
                              
                              var status = 15;
                              var nofitymsg = guardianshipmsg;
                              var routeddescription = guardianshipmsg;
                              var comments = guardianshipmsg;
                        var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
                        util.executeDBQuery(sql, [gapagreementrateid,securityusersid,'GARR',status,comments,'',false,false,false,nofitymsg,
                        routeddescription,request.servicecaseid,'',1])
                        .then(result => {
                            LOGGER.info(result);
                        })
                        .catch(err => {
                            LOGGER.error(err);
                            throw err;
                          })  
                            }
                          )
                      )
                  })
          }   else {

          if(request.courtstartdt && request.startdate){

              updateGaprateId=request.gapagreementid;
              sqlgapagreement = 'update gapagreement set startdate =$1, updatedby = $2, updatedon = now() where gapagreementid = $3';
              util.executeDBQuery(sqlgapagreement,[request.startdate,securityusersid,updateGaprateId])
              .then(_data => {
                  LOGGER.info(_data);
              })
              .catch(err => {
                  LOGGER.error(err);
                  throw err;
              })
          }  

           gapagreementrate.forEach(element => {
              var revisionObj = {};
                element.activeflag = 1;           
                element.insertedby=securityusersid;
                element.gapagreementid=gapagreementid;
                response.push(
                    app.models.Gapagreementrate.create(element).then(_data =>
                      {
                        gapagreementrateid=_data.gapagreementrateid;
			                  revisionObj.gaprateid=_data.gapagreementrateid;
                        revisionObj.guardiansubsidyid=request.gapid;
                        revisionObj.transactiondate=element.transactiondate;
                        revisionObj.paymentamt=element.paymentamout;
                        revisionObj.ratestartdate=element.startdate;
                        revisionObj.rateenddate=element.enddate;
                        revisionObj.activeflag=element.activeflag;
                        revisionObj.notes=element.comments;
                        revisionObj.providerid=element.providerid;
                        revisionObj.insertedby=element.insertedby;
                        revisionObj.approvalstatustypekey= '3045'; 
                        app.models.Gapratesrevision.create(revisionObj);	
                        
                        var status = 15;
                        var nofitymsg = guardianshipmsg;
                        var routeddescription = guardianshipmsg;
                        var comments = guardianshipmsg;
                var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
                util.executeDBQuery(sql, [gapagreementrateid,securityusersid,'GARR',status,comments,'',false,false,false,
                nofitymsg,routeddescription,request.servicecaseid,'',1])
                .then(result => {
                    LOGGER.info(result);
                })
                .catch(err => {
                    LOGGER.error(err);
                    throw err;
                })      
                      }
                    )
                )
            })
          }
            Promise.all(response).then(function (values) {
                values.map(x => {                   //SonarQube fix - removed the useless assignment
                    prs.push(x);
                });
            });
          }     
          return Promise.all(prs)
          .then(_data => "success")
          .catch(err =>err); 
        } 
    }

 
   
    Gapagreementrate.add =(request, reqctx) =>{
      const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        var result;
          var sql = 'select * from validateagreementrate($1,$2,$3)';

          return util.executeDBQuery(sql,[request.gapagreementid,request.ratestartdate,request.rateenddate])
            .then(data => {
              if(data){
                result = data[0];
              }

              if (result.statuscode === 200) {
                if (request.gapagreementid !== undefined && request.gapagreementid !== null) {
                  return Gapagreementrate.addrate(request, _securityusersid);
                }
              } else {
                return result.status_description;
              }
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    }


    Gapagreementrate.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Gapagreementrate.observe('access', (ctx, next) => util.access(ctx, next));
    Gapagreementrate.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
