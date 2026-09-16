'use strict';
const LOGGER = require("log4js").getLogger("beacon");
const app = require('../../server/server');
const crypto = require('crypto');
const util = require('../utils/utils');
const loopback = require('loopback');
const axios = require('axios');
const config = require('../../server/config.json');
const commonapi = require('../models/commonapi');
module.exports = function (beacon){


    beacon.addbeaconrequestdetails =function(request,reqctx){
        let suserid = util.getSecurityDetails(request, reqctx).securityuserid; 
        request.forEach((item) => { item.user_id = item.securityuserid ? item.securityuserid : suserid; });
      let Username =request[0]?.username ? request[0]?.username :null;
      let ssnarray =request.map(t=>t.ssn);
      if (request!=null && request!=undefined)
      {
        let sql = 'select * from cjams.addbeaconrequestdetails($1)';
        return util.executeDBQuery(sql,[JSON.stringify(request)]).then((data)=>{
          let existingdetails = data[0]?.addbeaconrequestdetails?.existingdetails;
                    if (existingdetails) {
                        ssnarray = ssnarray.filter(ssn => !existingdetails.some(detail => detail.ssn === ssn));
                    }
                    if(ssnarray.length > 0 ){
                      beaconrequestrealtimedatawithmultiplessn(ssnarray,data[0]?.addbeaconrequestdetails?.sourcetrackingid,suserid,Username);
                    }
                return data;
        }).catch((err)=>{
            LOGGER.error(err); 
            return err;
        });
      }
        return Promise.resolve('Invalid request');
    };

    beacon.remoteMethod(
          'addbeaconrequestdetails',
                {
                  http: {
                      path: '/addbeaconrequestdetails',
                      verb: 'post'
                  },
                  accepts : [ {arg : 'data',type : 'array',
                      http : {source : 'body'}}
                      ,{
                                  arg: 'reqctx',
                                  type: 'object',
                                  http: {source: 'context'}
                                } ],
                  returns: {
                    type : 'object',
                  root : true
                  }
                  }
        );


  function beaconrequestrealtimedatawithmultiplessn (ssn,sourcetrackingid,securityuserid,username) {
         let suserid =securityuserid;
          let ssnList = ssn ? ssn :null;
          let sourceTrackingid = sourcetrackingid ? sourcetrackingid:null;
          let Username = username || null;
          if (ssn == null || ssn == undefined || ssn == '' || ssn == 'null') {
            return Promise.resolve([])
          }
          const requestbody = {
            "SSNList": ssnList,
            "SourceTrackingId": sourceTrackingid
          };
          let cipherencryptvalue = util.cipherencrypt(requestbody);
          let encryptedvalue ={
            encrypted :cipherencryptvalue
          }
          let options = {
            url: config.beconConfig.beacondolmultissnrequesturl,
            json: true,
            body: encryptedvalue,
            headers: {
              Authorization:  app.get('apiKeys').beacon_bearer_token,
              "Content-Type": config.beconConfig.ContentType,
              Username: Username,
              uid: suserid,
              "Interface-Job-Source": config.beconConfig.beacondolJobSource,
              "interface-job-code": config.beconConfig.beacondoljobcodemultiple
            }
          };
          
          let externalapidata = {};   
					    externalapidata.details =  {
						objectid: sourceTrackingid,
						objecttype: 'beacon_SSN_request',
						objectsubtype: null,
						updatedby: suserid,
						insertedby: suserid
					}
					externalapidata.resstatus = ' ';
					externalapidata.request = options;
					externalapidata.response =null;
					externalapidata.status = 'add';
					let v_externalapilogsid = null;
					commonapi.addupdateexternalapilogs(externalapidata).then(_data => {
						v_externalapilogsid = _data;
					});

          return new Promise((resolve, reject) => {
            axios.post(options.url, options.body,{headers: options.headers})
            .then((res) => {
              const dataresolved = res.data;
              let data =JSON.parse(util.cipherdecrypt(dataresolved.encrypted));
              
              externalapidata.details =  {
                objectid: sourceTrackingid,
                objecttype: 'beacon_SSN_request',
                externalapilogsid:v_externalapilogsid,
                objectsubtype: null,
                updatedby: suserid,
                insertedby: suserid
              }
              let cipherdecryptvalue =JSON.parse(util.cipherdecrypt(data.encrypted));
              if (cipherdecryptvalue?.error && cipherdecryptvalue?.error?.length > 0) {
                externalapidata.resstatus = 'error'
              } else{
                externalapidata.resstatus = 'success';
              }
              externalapidata.request = options;
              externalapidata.response = cipherdecryptvalue;
              externalapidata.status = 'update';

              commonapi.addupdateexternalapilogs(externalapidata);
              resolve(cipherdecryptvalue);
            })
            .catch((err) => {
              externalapidata.details =  {
                objectid: sourceTrackingid,
                objecttype: 'beacon_SSN_request',
                externalapilogsid:v_externalapilogsid,
                objectsubtype: null,
                updatedby: suserid,
                insertedby: suserid
              }
              externalapidata.resstatus = 'error';
              externalapidata.request = options;             
              externalapidata.status = 'update';
              if (err.response) {
                  externalapidata.response = err.response.data;
                  commonapi.addupdateexternalapilogs(externalapidata);
                  LOGGER.error(err.response.data);
                  reject(err.response.data); 
                } else {
                  externalapidata.response = err;
                  commonapi.addupdateexternalapilogs(externalapidata);
                  LOGGER.error(err); 
                  reject(err);
                }         
            });
          })
        }

        beacon.getbeaconaudit = function (request,reqctx) {
          let sql = "SELECT * FROM cjams.getbeaconaudit($1,$2,$3)";

          let startdate =request.startdate ? request.startdate :null;
          let enddate =request.enddate ? request.enddate :null;
          let ssn =request.ssn ? request.ssn :null;
          return util.executeDBQuery(sql, [startdate,enddate,ssn])
            .then(data => util.encryptresponse(data))
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };

        beacon.remoteMethod('getbeaconaudit', {
          accepts: [{
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
          http: {
            path: '/getbeaconaudit',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });

        beacon.addbeaconaudit =function(request,reqctx){
          let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }

      let userid = request.securityuserid ? request.securityuserid :suserid;
      let event = request.event ? request.event :null;
      let eventpage = request.eventpage ? request.eventpage :null;
      let eventid = request.eventid ? request.eventid :null;
      let ssn = request.SSN ? request.SSN :null;
      let personid = request.personid ? request.personid :null;
      if (request!=null && request!=undefined)
      {
        let sql = 'select * from cjams.addbeaconaudit($1,$2,$3,$4,$5,$6)';
        return util.executeDBQuery(sql,[event,eventpage,eventid,userid,ssn,personid])
          .then(data => data)
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
      }
        return Promise.resolve('Invalid request');
    };

    beacon.remoteMethod(
          'addbeaconaudit',
                {
                  http: {
                      path: '/addbeaconaudit',
                      verb: 'post'
                  },
                  accepts : [ {arg : 'data',type : 'object',
                      http : {source : 'body'}}
                      ,{
                                  arg: 'reqctx',
                                  type: 'object',
                                  http: {source: 'context'}
                                } ],
                  returns: {
                    type : 'object',
                  root : true
                  }
                  }
        );

          beacon.beaconssnsearch = function (request) {

            let sql = "select * from cjams.beaconssnsearch($1)";
            return util.executeDBQuery(sql, [request])
              .then(data => util.encryptresponse(data))
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              });

          };

          beacon.remoteMethod('beaconssnsearch', {
            accepts: {
              arg: 'filter',
              type: 'Object',
              http: {
                source: 'query'
              },
              required: true
            },
            http: {
              path: '/beaconssnsearch',
              verb: 'get'
            },
            returns: {
              type: 'Object',
              root: true
            }
          });

          beacon.beaconcasesearch = function (request) {
            let caseId = request.case;
            let sql = 'select * from cjams.beaconcasesearch($1)';
            return util.executeDBQuery(sql, [caseId])
              .then(data => util.encryptresponse(data))
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              });

          };

          beacon.remoteMethod('beaconcasesearch', {
            accepts: {
              arg: 'filter',
              type: 'Object',
              http: {
                source: 'query'
              },
              required: true
            },
            http: {
              path: '/beaconcasesearch',
              verb: 'get'
            },
            returns: {
              type: 'Object',
              root: true
            }
          });

          beacon.getbeaconrequestdetails = function (request) {

            let sql = "SELECT * FROM cjams.getbeaconrequestdetails($1, $2, $3)";

            let ssnIds = null;
            if(request?.ssn?.length) {
              ssnIds = request?.ssn[0]?.split(',')
            }
            let caseId = request.case ? request.case :null;
            let requestedBy = request.requestby ? request.requestby :  null;
            return util.executeDBQuery(sql, [ssnIds, caseId, requestedBy])
              .then(data => util.encryptresponse(data))
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              });

          };

          beacon.remoteMethod('getbeaconrequestdetails', {
            accepts: {
              arg: 'filter',
              type: 'Object',
              http: {
                source: 'query'
              },
              required: true
            },
            http: {
              path: '/getbeaconrequestdetails',
              verb: 'get'
            },
            returns: {
              type: 'Object',
              root: true
            }
          });

          beacon.getbeaconvalidation = function (request) {

            let sql = "select * from beaconrequestdetails where  personid=$1 and activeflag=1";
            let personid = request.personid ? request.personid :null;
            var params = [personid];

            return util.executeDBQuery(sql, params)
              .then(data => {
                return data;
              })
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              });

          };

          beacon.remoteMethod('getbeaconvalidation', {
            accepts: {
              arg: 'filter',
              type: 'Object',
              http: {
                source: 'query'
              },
              required: true
            },
            http: {
              path: '/getbeaconvalidation',
              verb: 'get'
            },
            returns: {
              type: 'Object',
              root: true
            }
          });

          beacon.getbeaconrequesthistory = function (request) {

            let sql = "SELECT * FROM cjams.getbeaconrequesthistory($1)";

            let personid = request.personid ? request.personid :null;

            return util.executeDBQuery(sql, [personid])
              .then(data => util.encryptresponse(data))
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              });

          };

          beacon.remoteMethod('getbeaconrequesthistory', {
            accepts: {
              arg: 'filter',
              type: 'Object',
              http: {
                source: 'query'
              },
              required: true
            },
            http: {
              path: '/getbeaconrequesthistory',
              verb: 'get'
            },
            returns: {
              type: 'Object',
              root: true
            }
          });

          beacon.remoteMethod('getbeaconrequestedbylist', {
            http: {
              path: '/getbeaconrequestedbylist',
              verb: 'get'
            },
            returns: {
              type: 'Object',
              root: true
            }
          });

          beacon.getbeaconrequestedbylist = function () {

            let sql = `SELECT
                        up.securityusersid,
                        up.fullname
                      FROM v_userprofile up
                      INNER JOIN userresource ur ON up.userid = ur.userid
                      INNER JOIN role r ON ur.roleid = r.id
                      WHERE r.roletypekey in( 'CWDOLAA')
                      GROUP BY up.securityusersid, up.fullname
                      ORDER BY up.fullname asc `;
            var params = [];

            return util.executeDBQuery(sql, params)
              .then(data => {
                return data;
              })
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              });
          };

        beacon.observe('before save', (ctx, next) => util.beforesave(ctx, next));
        beacon.observe('access', (ctx, next) => util.access(ctx, next));
        beacon.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}