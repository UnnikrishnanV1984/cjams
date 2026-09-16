'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Collateral) {
    

    Collateral.addupdate =(request, reqctx)=>{
      const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
      const _vsecurityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid;
      const prs =[];
        var collateraladdress=request.collateraladdress;
        var collateralroleconfig=request.collateralroleconfig;
        var  rescollatralid = null;

     if(request.collateralid === undefined || request.collateralid === null)
      {
         return  Collateral.create({

            
            referralid:request.referralid, 
            caseid:request.caseid, 
            prefixtypekey:request.prefixtypekey, 
            firstname:request.firstname, 
            middlename:request.middlename, 
            lastname:request.lastname, 
            suffixtypekey:request.suffixtypekey, 
            dob:request.dob, 
            ssn:request.ssn,
            primaryracetypekey:request.primaryracetypekey, 
            relationshiptypekey:request.relationshiptypekey, 
            testifyflag:request.testifyflag, 
            attestableinfo:request.attestableinfo, 
            familyknowledge:request.familyknowledge, 
            comments:request.comments, 
            workphone:request.workphone, 
            workextn:request.workextn, 
            homephone:request.homephone, 
            pager:request.pager, 
            email:request.email, 
            fax:request.fax, 
            mobile:request.mobile, 
            url:request.url, 
            othercontacts:request.othercontacts, 
            datenotified:request.datenotified, 
            clientnotes:request.clientnotes, 
            legalclientid:request.legalclientid, 
            expungementflag:request.expungementflag, 
            datavalidflag:request.datavalidflag, 
            clientmergeid:request.clientmergeid, 
            agencyname:request.agencyname,
            intakenumber:request.intakenumber,
            title:request.title,
            objecttype:request.objecttype,                            
						insertedby: _vsecurityusersid,
            updatedby: _vsecurityusersid            
            }).then(data =>{

                rescollatralid = data.collateralid;
    
                if(Array.isArray(collateraladdress)){
                    collateraladdress.forEach(collAddr =>{
                      prs.push(
                          app.models.Collateraladdress.create({
      
                          collateralid:rescollatralid,                   
                          addresstypekey:collAddr.addresstypekey,
                          formattypekey:collAddr.formattypekey, 
                          streetnumber:collAddr.streetnumber,
                          streetsuffixtypekey:collAddr.streetsuffixtypekey,
                          postdirtypekey:collAddr.postdirtypekey,
                          unittypekey:collAddr.unittypekey,
                          unitnumbertx:collAddr.unitnumbertx,
                          cityname:collAddr.cityname,
                          countytypekey:collAddr.countytypekey,
                          statetypekey:collAddr.statetypekey,
                          zip5no:collAddr.zip5no,
                          zip4no:collAddr.zip4no,
                          direction:collAddr.direction,
                          foreignaddress:collAddr.foreignaddress,
                          foreignstate:collAddr.foreignstate,
                          country:collAddr.country,
                          postalcode:collAddr.postalcode,
                          defaultflag:collAddr.defaultflag,
                          startdate:collAddr.startdate,
                          enddate:collAddr.enddate,
                          address2:collAddr.address2, 
                          address1:collAddr.address1,                         
                          insertedby: _vsecurityusersid,
                          updatedby: _vsecurityusersid                          })
                      )
                  });
              }
              if(Array.isArray(collateralroleconfig)){
                collateralroleconfig.forEach(collRoleConfig =>{
                  prs.push(
                      app.models.Collateralroleconfig.create({
  
                      collateralid:rescollatralid,         
                      actortypekey:collRoleConfig.actortypekey,                                             
                      insertedby: _vsecurityusersid,
                      updatedby: _vsecurityusersid                      })
                  )
              });
          }
              return Promise.all(prs);
      
              })	
        }
        else
        {
            prs.push( Collateral.updateAll(
                { collateralid:request.collateralid},
                {
                    referralid:request.referralid, 
                    caseid:request.caseid, 
                    prefixtypekey:request.prefixtypekey, 
                    firstname:request.firstname, 
                    middlename:request.middlename, 
                    lastname:request.lastname, 
                    suffixtypekey:request.suffixtypekey, 
                    dob:request.dob, 
                    ssn:request.ssn,
                    primaryracetypekey:request.primaryracetypekey, 
                    relationshiptypekey:request.relationshiptypekey, 
                    testifyflag:request.testifyflag, 
                    attestableinfo:request.attestableinfo, 
                    familyknowledge:request.familyknowledge, 
                    comments:request.comments, 
                    workphone:request.workphone, 
                    workextn:request.workextn, 
                    homephone:request.homephone, 
                    pager:request.pager, 
                    email:request.email, 
                    fax:request.fax, 
                    mobile:request.mobile, 
                    url:request.url, 
                    othercontacts:request.othercontacts, 
                    datenotified:request.datenotified, 
                    clientnotes:request.clientnotes, 
                    legalclientid:request.legalclientid, 
                    expungementflag:request.expungementflag, 
                    datavalidflag:request.datavalidflag, 
                    clientmergeid:request.clientmergeid, 
                    agencyname:request.agencyname,
                    intakenumber:request.intakenumber,
                    title:request.title,
                    objecttype:request.objecttype,                                    
                    updatedby: _securityusersid     
                }
                ));
                prs.push( app.models.Collateraladdress.updateAll(
                    {collateralid:request.collateralid},
                    { activeflag:0  }
                
                  ));
                  prs.push( app.models.Collateralroleconfig.updateAll(
                    {collateralid:request.collateralid},
                    { activeflag:0  }
                
                  ));

                  if(Array.isArray(collateraladdress)){
                    collateraladdress.forEach(collAddr =>{
                        prs.push(
                            app.models.Collateraladdress.create({
        
                            collateralid:request.collateralid,                     
                            addresstypekey:collAddr.addresstypekey,
                            formattypekey:collAddr.formattypekey, 
                            streetnumber:collAddr.streetnumber,
                            streetsuffixtypekey:collAddr.streetsuffixtypekey,
                            postdirtypekey:collAddr.postdirtypekey,
                            unittypekey:collAddr.unittypekey,
                            unitnumbertx:collAddr.unitnumbertx,
                            cityname:collAddr.cityname,
                            countytypekey:collAddr.countytypekey,
                            statetypekey:collAddr.statetypekey,
                            zip5no:collAddr.zip5no,
                            zip4no:collAddr.zip4no,
                            direction:collAddr.direction,
                            foreignaddress:collAddr.foreignaddress,
                            foreignstate:collAddr.foreignstate,
                            country:collAddr.country,
                            postalcode:collAddr.postalcode,
                            defaultflag:collAddr.defaultflag,
                            startdate:collAddr.startdate,
                            enddate:collAddr.enddate,
                            address2:collAddr.address2,
                            address1:collAddr.address1,        
                            insertedby: _vsecurityusersid,
                            updatedby: _vsecurityusersid
                            })
                        )
                    });
                }
                if(Array.isArray(collateralroleconfig)){
                    collateralroleconfig.forEach(collRoleconfig =>{
                      prs.push(
                          app.models.Collateralroleconfig.create({
                            collateralid:request.collateralid,       
                            actortypekey:collRoleconfig.actortypekey,                                             
                            insertedby: _securityusersid,
                            updatedby: _securityusersid                          
                        })
                      )
                  });
              }
                return Promise.all(prs);

              }
    }

     


    Collateral.remoteMethod (
        'addupdate',
        {
          http: {
                  path: '/addupdate',
                  verb: 'post'
          },
          accepts: [{
                  arg: 'data',
                  type: 'Object',
                  http: {
                      source: 'body'
                  }
          }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
            }],
          returns: {
                  arg: 'data',
                  type: 'Object'
          }
         }
         );


         function padLeft(text, padChar, size) {
            return (String(padChar).repeat(size) + text).substr( (size * -1), size) ;
          }

             Collateral.list = request => {
           const sql = 'select * from getcollateraldetails($1,$2)';
            return util.executeSecondaryNodeDBQuery(sql, [request.where.objectid,request.where.objecttype])
            .then(data => {
               if(data && data.length>0 && data[0].getcollateraldetails && data[0].getcollateraldetails.length > 0 ){
                data[0].getcollateraldetails.forEach((collateral) => {
                  if(collateral.collateraladdress && collateral.collateraladdress.length > 0){
                    collateral.collateraladdress.forEach((coltrlads) =>{
                      if(coltrlads.zip5no){
                        coltrlads.zip5no = padLeft(coltrlads.zip5no.toString(), '0', 5);
                      }
                    });
                  }
                });
               }
              return data;
            }).then(dta => {
              return util.encryptresponse(dta);
            })
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
          };
        
        
          Collateral.remoteMethod('list', {
            accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                    source : 'query'
                },
                required : true
            },
            http : {
                verb : 'get'
            },
            returns : {
                type : 'Object',
                root : true
            }
        });

        Collateral.deletecollateral = id => {
            return Collateral.updateAll({collateralid: id}, {activeflag: 0})
            .then(data => data)
            .catch(err => util.logError(err));
        };
    
        Collateral.remoteMethod('deletecollateral', {
            http: {
                    path: '/deletecollateral/:id',
                    verb: 'delete'
            },
            accepts : [{
                arg: 'id',
                type: 'string',
                required: true,
                http: {source: 'path'}
            }],
            returns: {
                type : 'object',
                root : true
            }
        
        });
        
  
  
	Collateral.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Collateral.observe('access', (ctx, next) => util.access(ctx, next));
    Collateral.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};