'use strict';
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("quickperson");
var app = require('../../server/server');

module.exports = function(Quickperson) {
    

    Quickperson.addupdate =async (request,reqctx)=>{
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        var _email = util.getSecurityDetails(request, reqctx).email;
        var requestuserinfo = {'token': '', 'email': _email}; 
        var userrole ;
        await util.getuserinfo(requestuserinfo).then (data => {
            userrole = data.roletypekey;
        }); 
        const prs =[];
        var quickpersonroleconfig=request.quickpersonroleconfig;
        var quickpersonsubstconfig=request.quickpersonsubstconfig;
        var  resquickpersonid = null;
        var intakenumber = nullCheck(request.intakenumber);
        var babyname = request.firstname + ' ' + request.lastname;
        var objecttype = request.objecttype;
        var drugexposednewbornflag = nullCheck(request.drugexposednewbornflag);
     if(util.nullcheck(request.quickpersonid) === '')
      {
         return  Quickperson.create({
            intakenumber:request.intakenumber,
            caseid:request.caseid, 
            firstname:request.firstname, 
            middlename:request.middlename, 
            lastname:request.lastname, 
            dob:request.dob, 
            ssn:request.ssn,
            gendertypekey: request.gender,
            substanceexposednewbornflag:request.drugexposednewbornflag,
            legalclientid:request.legalclientid, 
            expungementflag:request.expungementflag, 
            datavalidflag:request.datavalidflag, 
            clientmergeid:request.clientmergeid,  
            objecttype:request.objecttype,    
            insertedby:  suserid,
            updatedby:  suserid        
            
            }).then(data =>{

                resquickpersonid = data.quickpersonid;
    
              if(Array.isArray(quickpersonroleconfig)){
                quickpersonroleconfig.forEach(quickpersonroleconfig1 =>{
                    prs.push(
                        app.models.Quickpersonroleconfig.create({
    
                        quickpersonid:resquickpersonid,         
                        actortypekey:quickpersonroleconfig1.actortypekey,   
                        insertedby: suserid,
                        updatedby: suserid                                  
                        })
                    )
                });
              }

              if(Array.isArray(quickpersonsubstconfig)){
                quickpersonsubstconfig.forEach(quickpersonsubstconfig2 =>{
                    prs.push(
                        app.models.Quickpersonsubstconfig.create({
    
                        quickpersonid:resquickpersonid,           
                        substanceclasskey:quickpersonsubstconfig2.substanceclasskey,     
                        insertedby: suserid,
                        updatedby: suserid                                
                        })
                    )
                });
              } 
              if(drugexposednewbornflag) {
                  var fromuserid = suserid; 
                
                  const sql = 'select * from send_notification_for_qpsen($1,$2, $3, $4, $5, $6)';
                  util.executeDBQuery(sql,[fromuserid,intakenumber,babyname,objecttype,userrole,true])
                  .then(data1 => {
                      return data1;
                    })
                  .catch(err => {
                      LOGGER.error(err)
                      throw err;
                    })
              }

              return Promise.all(prs);
      
              })	
        }
        else
        {
            prs.push( Quickperson.updateAll(
                { quickpersonid:request.quickpersonid},
                { 
                    intakenumber:request.intakenumber,
                    caseid:request.caseid,  
                    firstname:request.firstname, 
                    middlename:request.middlename, 
                    lastname:request.lastname,  
                    dob:request.dob, 
                    ssn:request.ssn, 
                    gendertypekey: request.gender,
                    substanceexposednewbornflag:request.drugexposednewbornflag,
                    legalclientid:request.legalclientid, 
                    expungementflag:request.expungementflag, 
                    datavalidflag:request.datavalidflag, 
                    clientmergeid:request.clientmergeid, 
                    objecttype:request.objecttype,                                    
                    updatedby:suserid     
                }
                ));
                  
                  prs.push( app.models.Quickpersonroleconfig.updateAll(
                    {quickpersonid:request.quickpersonid},
                    { activeflag:0  }
                
                  ));
                  prs.push( app.models.Quickpersonsubstconfig.updateAll(
                    {quickpersonid:request.quickpersonid},
                    { activeflag:0  }
                
                  ));
 
                if(Array.isArray(quickpersonroleconfig)){
                      quickpersonroleconfig.forEach(quickpersonroleconfig1 =>{
                        prs.push(
                            app.models.Quickpersonroleconfig.create({
        
                            quickpersonid:request.quickpersonid,       
                            actortypekey:quickpersonroleconfig1.actortypekey,      
                            insertedby: suserid,
                            updatedby: suserid                                 
                            })
                        )
                    });
                }
                if(Array.isArray(quickpersonsubstconfig)){
                      quickpersonsubstconfig.forEach(quickpersonsubstconfig2 =>{
                        prs.push(
                            app.models.Quickpersonsubstconfig.create({
        
                            quickpersonid:request.quickpersonid,         
                            substanceclasskey:quickpersonsubstconfig2.substanceclasskey,     
                            insertedby: suserid,
                            updatedby: suserid                             
                            })
                        )
                    });
                }
                return Promise.all(prs);

              }
    }

    function nullCheck(value) {
      return value ? value : null;
    }

     


    Quickperson.remoteMethod (
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
          },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
          returns: {
                  arg: 'data',
                  type: 'Object'
          }
         }
         );


       Quickperson.list = request => {
    
            const sql = 'select * from getquickpersondetails($1,$2,$3)';
            return util.executeSecondaryNodeDBQuery(sql, [request.where.objectid,request.where.objecttype, request.where.intakenumber])
            .then(data => {
              return util.encryptresponse(data);
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
          };
        
        
          Quickperson.remoteMethod('list', {
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

        Quickperson.exposednewborn = request => {

          const sql = "select case when exists (select distinct p.substanceexposednewbornflag, p.personid from person p join actor a on a.personid = p.personid and a.intakenumber = $1 and a.activeflag = 1 where p.substanceexposednewbornflag = 1 and p.substanceexposednewbornsourceid = $1) then 'FALSE' else 'TRUE' end";
          return util.executeDBQuery(sql, [ request.where.intakenumber])
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };
      
        Quickperson.remoteMethod('exposednewborn', {
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

        Quickperson.deletequickperson = (id,reqctx) => {
          let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
            return Quickperson.updateAll({quickpersonid: id}, {activeflag: 0, deletestatus:'A', updatedon:new Date(), updatedby:(request && request.securityuserid?request.securityuserid: suserid)})
            .then(data => data)
            .catch(err => util.logError(err));
        };
    
        Quickperson.remoteMethod('deletequickperson', {
            http: {
                    path: '/deletequickperson/:id',
                    verb: 'delete'
            },
            accepts : [{
                arg: 'id',
                type: 'string',
                required: true,
                http: {source: 'path'}
            },
            {
              arg: 'reqctx',
       type: 'object',
        http: {source: 'context'}
          }],
            returns: {
                type : 'object',
                root : true
            }
        
        });

        Quickperson.deleterequest = async (request,reqctx) => {
          let suserid = undefined;
          if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            suserid = reqctx.req.headers.securityusersid
          }
          var _email;
          if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
              _email = reqctx.req.headers.user_email_captureby_application;
          }  
          var requestuserinfo = {'token': '', 'email': _email}; 
          var userrole ;
          await util.getuserinfo(requestuserinfo).then (data => {
            userrole = data.roletypekey;
          }); 
          var  quickpersonid = request.quickpersonid;
          var  objecttype  = request.objecttype;
          var  intakenumber = request.intakenumber ? request.intakenumber : null; 
          var deletetype = request.deletetype;
          var caseid = request.caseid;
          var casenumber = request.caseNumber ? request.caseNumber : null;
          const reqquery = 'select * from deletequickperson($1,$2,$3,$4,$5,$6,$7, $8)';
          return util.executeDBQuery(reqquery, [deletetype, quickpersonid, intakenumber, objecttype, (request && request.securityuserid?request.securityuserid:suserid), userrole, caseid, casenumber])
            .catch(err => util.logError(err));
        };
    
        Quickperson.remoteMethod('deleterequest', {
            http: {
                    path: '/deleterequest',
                    verb: 'post'
            },
            accepts : [ {arg : 'data',type : 'Object',
                http : {source : 'body'}},{
                  arg: 'reqctx',
                  type: 'object',
                  http: {source: 'context'}
                } ],
            returns: {
                type : 'Object',
                root : true
            }
        });
        
  
  
	Quickperson.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Quickperson.observe('access', (ctx, next) => util.access(ctx, next));
    Quickperson.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};