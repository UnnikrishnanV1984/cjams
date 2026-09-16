'use strict';
const LOGGER = require("log4js").getLogger("tb_vendor_addresses");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_vendor_addresses) {

    Tb_vendor_addresses.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
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
            type : 'string',
            root : true
        }
    });   

    Tb_vendor_addresses.addupdate = function(request,reqctx)
    { 
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        if(request.vendoraddressid=== null || request.vendoraddressid === undefined)
        {
            request.create_ts=new Date().toLocaleString();
            request.create_user_id = suserid;
            request.update_user_id = suserid;
            request.update_ts = new Date().toLocaleString();
            request.isaddress = true;
            if(!request.adr_start_dt){
                request.adr_start_dt=new Date().toLocaleString();  
            }
            return Tb_vendor_addresses.create(request)
            .then(res => res)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
        else
        {
            request.update_user_id = suserid;
            request.update_ts = new Date().toLocaleString();
          return Tb_vendor_addresses.updateAll({vendoraddressid:request.vendoraddressid},request)
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
    };

    Tb_vendor_addresses.remoteMethod('checktaxiddup', {
        http: {
            path: '/checktaxiddup',
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

    Tb_vendor_addresses.checktaxiddup = function(request){
            var sql = "select taxid,org_nm,ct.countyname as jurisdiction_desc from tb_vendor_applicant tva inner join county ct on ct.countyid = (tva.jurisdiction)::uuid where tva.taxid=$1 and tva.vendorid!=$2 and tva.delete_sw='N'"
            return util.executeDBQuery(sql,[request.where.taxid,request.where.vendorid])
          .then(res =>{
            return res
          })
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }

        Tb_vendor_addresses.remoteMethod('updatemanagedetails', {
            http: {
                    path: '/updatemanagedetails',
                    verb: 'post'
            },
            accepts : [ {arg : 'data',type : 'object',
                http : {source : 'body'}} ],
            returns: {
                type : 'string',
                root : true
            }
        });
      
        Tb_vendor_addresses.updatemanagedetails = function(request)
        {
                var sql = "select * from updatemanageapplicantdetails($1)"
                return util.executeDBQuery(sql, [request])
              .then(res =>{
                return res
              })
              .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        };


        Tb_vendor_addresses.remoteMethod('getaddresslist', {
            http: {
                path: '/getaddresslist',
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
    
        Tb_vendor_addresses.getaddresslist = function(request){
                var sql = "select *,tpv.value_tx as adr_county_nm from tb_vendor_addresses tva inner join tb_picklist_values tpv on trim(tpv.picklist_value_cd) = trim(tva.adr_county_cd) and tpv.picklist_type_id='328' where tva.delete_sw='N' and tva.vendorapplicantid=$1"
                return util.executeDBQuery(sql,[request.where.vendorapplicantid])
              .then(res =>{
                return res
              })
              .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            }


    Tb_vendor_addresses.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_vendor_addresses.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_vendor_addresses.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}