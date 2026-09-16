'use strict';
const LOGGER = require("log4js").getLogger("psychotropicmedicationreport");
let app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
let config = require('../../server/config.json');
const email = require('../models/email');

module.exports = function (psychotropicmedicationreport){

        psychotropicmedicationreport.remoteMethod('getpsychotropicmedicationreportdetails', {
          accepts:[ {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
          http: {
            path: '/getpsychotropicmedicationreportdetails',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });
        psychotropicmedicationreport.getpsychotropicmedicationreportdetails = function (request,reqctx) {
          let _securityusersid = undefined;
          if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            _securityusersid = reqctx.req.headers.securityusersid;
          }  
          let startdate =nullcheck(request.where.startdate);
          let enddate =nullcheck(request.where.enddate);
          let medicationname =nullcheck(request.where.medicationname);
          let prescribername =nullcheck(request.where.prescribername);
          let dateprescribed =nullcheck(request.where.dateprescribed);
          let filterdatetype =nullcheck(request.where.filterdatetype);
          let clientname =nullcheck(request.where.clientname);
          let age =nullcheck(request.where.age);
          let psychotropicrequestid =nullcheck(request.where.psychotropicrequestid);
          let caseid =nullcheck(request.where.caseid);
          let reviewcoordinator =nullcheck(request.where.reviewcoordinator);
          let pharmacist =nullcheck(request.where.pharmacist);
          let psychiatrist =nullcheck(request.where.psychiatrist);
          let countyid =nullcheck(request.where.countyid);
          let turnaround =nullcheck(request.where.turnaround);
          let teamid =nullcheck(request.where.teamid);
          let pagenumber =request.where?.pagenumber ?request.where?.pagenumber:1;
          let pagesize =request.where?.pagesize ?request.where?.pagesize:10;
          let sortcolumn =nullcheck(request.where?.sortcolumn);
          let sortorder =nullcheck(request.where?.sortorder);
          let countfilter =nullcheck(request.where?.countfilter);
          let searchobj =nullcheck(request.where?.searchobj);
          let calendardays =nullcheck(request.where?.calendardays);
          let submissiondate =nullcheck(request.where?.submissiondate);
          let caseworkid =nullcheck(request.where?.caseworkid);
          let sql=null;
          if (calendardays){
             sql = 'select * from getpsychotropicmedicationreport($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24) ';
          }
          else{
             sql = 'select * from getpsychotropicmedicationreportbusinessdays($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24) ';
          }
          let params = [startdate,enddate,medicationname, prescribername, dateprescribed,submissiondate,filterdatetype,clientname,age,
            psychotropicrequestid,caseid,reviewcoordinator,pharmacist,psychiatrist,countyid,turnaround,teamid,pagenumber,pagesize,sortcolumn,sortorder,countfilter,searchobj,caseworkid];

          return util.executeDBQuery(sql, params)
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };

        function nullcheck(value){
          return value || null;
        }

        psychotropicmedicationreport.getPsychotropiccwlistbycounty = function (request) {

          let sql = "select * from getPsychotropiccwlistbycounty($1,$2)";

        let countyid =request.where.countyid ? request.where.countyid : null
        let teamid =request.where.teamid ? request.where.teamid : null
          let params = [countyid,teamid];
          return util.executeDBQuery(sql, params)
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };
      
        psychotropicmedicationreport.remoteMethod('getPsychotropiccwlistbycounty', {
          accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          },
          http: {
            path: '/getPsychotropiccwlistbycounty',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });

        psychotropicmedicationreport.remoteMethod('getpsychotropiccalculateavgtime', {
          accepts:[ {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
          http: {
            path: '/getpsychotropiccalculateavgtime',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });

        psychotropicmedicationreport.getpsychotropiccalculateavgtime = function (request,reqctx) {
        
          let startdate =request?.where?.startdate?request?.where?.startdate:null;
          let enddate =request?.where?.enddate?request?.where?.enddate:null;
          let medicationname =request?.where?.medicationname?request?.where?.medicationname:null;
          let prescribername =request?.where?.prescribername?request?.where?.prescribername:null;
          let dateprescribed =request?.where?.dateprescribed?request?.where?.dateprescribed:null;
          let filterdatetype =request?.where?.filterdatetype?request?.where?.filterdatetype:null;
          let clientname =request?.where?.clientname ?request?.where?.clientname:null;
          let age =request?.where?.age ?request?.where?.age:null;
          let countyid =request?.where?.countyid ?request?.where?.countyid:null;
          let teamid =request?.where?.teamid ?request?.where?.teamid:null;
          let calendardays =request.where?.calendardays ?request.where?.calendardays:null;
          let submissiondate =request.where?.submissiondate ?request.where?.submissiondate:null;
          let caseworkid =request.where?.caseworkid ?request.where?.caseworkid:null;
          let sql = '';
          if (calendardays){
             sql = 'select * from getpsychotropiccalculateavgtime($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
          }
          else{
             sql = 'select * from getpsychotropiccalculateavgtimebusinessdays($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
          }
          return util.executeDBQuery(sql, [medicationname,prescribername,dateprescribed,submissiondate,filterdatetype,clientname,age,countyid,startdate,enddate,teamid,caseworkid]).then((data)=>{
              return data; 
          }).catch((err4)=>{
              LOGGER.error(err4); 
              throw err4;
          });
        };

        psychotropicmedicationreport.remoteMethod('getpsychotropiclistbyrequestid', {
          accepts:[ {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
          http: {
            path: '/getpsychotropiclistbyrequestid',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });

        psychotropicmedicationreport.getpsychotropiclistbyrequestid = function (request,reqctx) {
        
          let psychotropicrequestid= request.where.psychotropicrequestid?request.where.psychotropicrequestid:null;
        
          let sql = 'select * from getpsychotropiclistbyrequestid($1) ';

          return util.executeDBQuery(sql, [psychotropicrequestid]).then((data)=>{
              return data; 
          }).catch((err4)=>{
              LOGGER.error(err4); 
              throw err4;
          });
        };

        psychotropicmedicationreport.remoteMethod('getholidayslist', {
          accepts:[  ],
          http: {
            path: '/getholidayslist',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });
      
      psychotropicmedicationreport.getholidayslist = () => {
      
        let sql = 'select * from cjams.getholidayslist()';
      
        return util.executeDBQuery(sql, []).then( (data)=>{
         return data;
        }).catch((err) => {
          LOGGER.error(err);
        });
      };

        psychotropicmedicationreport.observe('before save', (ctx, next) => util.beforesave(ctx, next));
        psychotropicmedicationreport.observe('access', (ctx, next) => util.access(ctx, next));
        psychotropicmedicationreport.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}