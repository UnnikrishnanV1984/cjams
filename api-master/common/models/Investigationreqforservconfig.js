'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function (Investigationreqforservconfig) {
  
  Investigationreqforservconfig.remoteMethod('addupdate', {
    http: {
            path: '/addupdate',
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
    


      Investigationreqforservconfig.addupdate  = (request, reqctx)=>{
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        return Investigationreqforservconfig.create({
            intakeserviceid : request.intakeserviceid,
            intakeservtypekey:request.intakeservtypekey,
            reqforservstatus:request.reqforservstatus,          
            reqforservdispostion:request.reqforservdispostion,
            programtype:request.programtype,
            removalreasontypekey:request.removalreasontypekey,
            removalreasonother:request.removalreasonother,
            receiveddate:request.receiveddate,
            closeddate:request.closeddate,
            insertedby : request && request.securityuserid?request.securityuserid: _securityusersid,
             updatedby : request && request.securityuserid?request.securityuserid: _securityusersid,
             insertedon: new Date().toLocaleString(),
             updatedon: new Date().toLocaleString()
        })
    }


    Investigationreqforservconfig.remoteMethod(
        'listservicestatus',
        {
          http: {
            path: '/listservicestatus',
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

      Investigationreqforservconfig.listservicestatus = (data, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        const userid = data && data.securityuserid?data.securityuserid: _securityusersid;
        var Totalcount = 0;
        var pageNumber = data.page;
        var pageLimit = data.limit;
        var Reqforservice = data.where.Reqforservice;
        var status = data.status;
        var sortcolumn = data.where.sortcolumn;
        var sortorder = data.where.sortorder;

        if (sortcolumn == null || sortcolumn === undefined) {sortcolumn = "receiveddate";}
        if (sortorder == null || sortorder === undefined) {sortorder = "desc";}
        var sql = '';

        sql = 'select * from listinvestigatonservicestatus($1,$2,$3,$4,$5,$6,$7)';

        const params = [userid,status, Reqforservice, pageNumber, pageLimit, sortcolumn, sortorder];

        return util.executeDBQuery(sql, params)
          .then(res => {
            if (res!=null && res.length > 0) {Totalcount = res[0].totalcount;}
            return {
              'data': res,
              'count': Totalcount
            };
          })
          .catch(err => err);

      };

      Investigationreqforservconfig.remoteMethod('removalservicestatus', {
        http: {
                path: '/removalservicestatus',
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
      

    Investigationreqforservconfig.removalservicestatus  = (request, reqctx)=>{
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
        return Investigationreqforservconfig.updateAll(
            {
                investigationreqforservconfigid: request.investigationreqforservconfigid
            },
            {
                   
            reqforservstatus:request.reqforservstatus,         
            removalreasontypekey:request.removalreasontypekey,
            removalreasonother:request.removalreasonother,
            closeddate:request.closeddate,
            updatedby : request && request.securityuserid?request.securityuserid: _securityusersid,
            updatedon: new Date().toLocaleString()
        }).then(res=>{
            return  request;
        }).catch(err => util.logError(err));
    }

    
    
    Investigationreqforservconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationreqforservconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationreqforservconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
        


}