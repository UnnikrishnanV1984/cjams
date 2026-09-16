'use strict';
const LOGGER = require("log4js").getLogger("caseplan");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const pdf = require('../models/pdf');

module.exports = function (Caseplan) {

    Caseplan.generatecaseplansnapshot = (request, reqctx ) => {
      let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
        request.securityuserid = (request&&request.securityuserid)?request.securityuserid:suserid;
        const sql = "SELECT * FROM generatecaseplansnapshot($1)";
        return util.executeDBQuery(sql, [JSON.stringify(request)]).then((data) => {
                return data;
        }).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
    };


    Caseplan.remoteMethod('generatecaseplansnapshot', {
        http: {
            path: '/generatecaseplansnapshot',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        }, {
          arg: 'reqctx',
          type: 'object',
           http: {source: 'context'}
          }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Caseplan.getReportCaseplan = (request,res) =>{
        return new Promise((resolve, reject) => {
        res.on('data', function (chunk) {
            LOGGER.debug('BODY: ' + chunk);
        });
        res = pdf.casePlan2PDF(request, res);
        resolve(res);
      });
    }

    Caseplan.remoteMethod('getReportCaseplan', {

        http: {
            path: '/getReportCaseplan',
            verb: 'post'
        },
        accepts: [{
                arg: 'data',
                type: 'Object',
                http: {
                    source: 'body'
                }
            },
            {
                arg: 'res',
                type: 'object',
                'http': {
                    source: 'res'
                }
            }

        ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
    })


    Caseplan.casePlanRouting = function (request,reqctx) {
      let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
        var userid = (request.securityuserid ? request.securityuserid : suserid);
        var objectId=request.objectid;
        var toUserID=request.tosecurityusersid;
        var eventcode=request.eventcode;
        var serviceNumber=request.serviceNumber;
        var status = 15;
        var nofitymsg = 'Case plan Submitted for review';
        LOGGER.debug(nofitymsg);
        if (request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() === "return") {
          status = 17;
          nofitymsg = 'Case plan Returned';
        }
        else if (request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() === "approved") {
          status = 16;
          nofitymsg = 'Case plan Approved ';
        }
        LOGGER.debug(nofitymsg);
        
        if(!objectId){
            objectId ='';
        }
  
        if(!toUserID){
          toUserID='';
        }
  
        if(!eventcode){
          eventcode='';
        }
  
        if(!serviceNumber){
            serviceNumber=0;
        }
        
        var sql = 'select * from caseplanrouting($1,$2,$3,$4,$5,$6,$7,$8,$9)';
        return util.executeDBQuery(sql, [objectId, userid,toUserID, status,eventcode, nofitymsg,nofitymsg,serviceNumber,request.approvalstatustypekey.toLowerCase()])
        .then(data => ({
          data: data
        }))
        .catch(err => util.logError(err));
      }
  
      Caseplan.remoteMethod(
        'casePlanRouting', {
          http: {
            path: '/caseplanrouting',
            verb: 'post'
          },
          accepts: [{
            arg: 'data',
            type: 'object',
            http: {
              source: 'body'
            }
          }, {
            arg: 'reqctx',
            type: 'object',
             http: {source: 'context'}
            }],
          returns: {
            type: 'object',
            root: true
          }
        }
      );

    Caseplan.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Caseplan.observe('access', (ctx, next) => util.access(ctx, next));
    Caseplan.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}