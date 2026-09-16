'use strict';
const LOGGER = require("log4js").getLogger("tb_provider_services");
const util = require('../utils/utils');
var app = require('../../server/server');

const loopback = require('loopback');

module.exports = function(Tb_provider_services) {


    Tb_provider_services.remoteMethod('getprovideraddress', {
        http: {
            path: '/getprovideraddress',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Tb_provider_services.getprovideraddress =(request)=> {
        var providerid= request.where.providerid;
        var page = request.page;
        var limit = request.limit;
        var req_intakenumber= providerid
        var req_intakeserviceid = request.where.intakeserviceid;
        var req_servicerequestnumber= request.where.servicerequestnumber;
      
   
        var sql = 'select * from getpersonsbyinvestigationcw($1,$2,$3,$4,$5)';
        var params = [page, limit,req_intakeserviceid,req_intakenumber,req_servicerequestnumber];

        return util.executeDBQuery(sql, params)
        .then(data => {
            if(data.length === 1){
                return data.filter(f=>{
                    if(f.rolename === 'APLCNT'){
                        return f.personid
                    }
                }) 
            }else if(data.length>1){
            return data.filter(f=>{
                if(f.rolename === 'APLCNT' && f.isheadofhousehold=== true){
                    return f.personid
                }
            })
        }
            }
        ).then(persondata=>{
            return util.executeDBQuery('select * from getpersonaddressphonenumber($1)', [persondata[0].personid])
            .then(result => {
                return result;
            })
            .then(finalresult=>finalresult)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

            })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Tb_provider_services.remoteMethod('getproviderchilddetails', {
        http: {
            path: '/getproviderchilddetails',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Tb_provider_services.getproviderchilddetails =(request)=> {
        var providerid= request.where.providerid;
      
   
        var sql = 'select * from get_providerchilddetails($1,$2,$3)';

        return util.executeDBQuery(sql, [providerid,request.page,request.limit])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    Tb_provider_services.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_provider_services.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_provider_services.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
