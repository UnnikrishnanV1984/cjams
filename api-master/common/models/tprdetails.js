'use strict';
const LOGGER = require("log4js").getLogger("tprdetails");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Tprdetails) {

    Tprdetails.gettprdetails = function(request) {
        var sql = 'select * from gettprdetails($1,$2, $3)';
        var clientidparam = request.where.spclientid ? request.where.spclientid : null;
        var includetprunknownparent = request.where.includeunknownparent ? request.where.includeunknownparent : null;

        return util.executeSecondaryNodeDBQuery(sql,[request.where.servicecaseid, clientidparam, includetprunknownparent])
        .then(data => {
            return data;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }
      
    Tprdetails.remoteMethod('gettprdetails', {
        http: {
            path: '/gettprdetails',
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


    Tprdetails.getadoptiondetails = function(request) {
        var sql = 'select * from getadoptiondetails($1)';

        return util.executeSecondaryNodeDBQuery(sql,[request.where.client])
        .then(data => {
            return data;
        })
        .then(data => { return data; })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }
      
    Tprdetails.remoteMethod('getadoptiondetails', {
        http: {
            path: '/getadoptiondetails',
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

    Tprdetails.remoteMethod('addtprdetail', {
        http: {
                path: '/addtprdetail',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Tprdetails.addtprdetail = request => {

        const sql = 'select * from addTPRDetails($1::json)';

        return util.executeDBQuery(sql, [request])
        .then(result => {
            return result;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    
    Tprdetails.singleparentcheckinfo = function(request) {
        var clientidparam = request.where.spclientid ? request.where.spclientid : null;
        var sql = `select (case when COALESCE(TBA.co_applicant_sw, '') <> 'Y' then false else true end) as singleparent
                    FROM 	adoptioncase ac join adoptioncaseactor acar on ac.adoptioncaseid = acar.adoptioncaseid
                    join person pr on pr.personid = acar.personid and pr.activeflag =1
                    join adoptioncaseagreement aca on aca.adoptioncaseid = acar.adoptioncaseid
                    join tb_provider_approval TBA  on TBA.provider_id = aca.providerid::numeric
                    where pr.personid=$1 AND TBA.active_sw = 'Y' AND DELETE_SW = 'N' ORDER BY TBA.approval_dt DESC LIMIT 1`;

        return util.executeDBQuery(sql, [clientidparam])
        .then(data => {
            return data;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }
      
    Tprdetails.remoteMethod('singleparentcheckinfo', {
        http: {
            path: '/singleparentcheckinfo',
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

    Tprdetails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tprdetails.observe('access', (ctx, next) => util.access(ctx, next));
    Tprdetails.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};