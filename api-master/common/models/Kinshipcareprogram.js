'use strict';
const LOGGER = require("log4js").getLogger("Kinshipcareprogram");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Kinshipcareprogram) { 

    Kinshipcareprogram.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        if(request.kinshipcareprogramid !== undefined && request.kinshipcareprogramid !== null) {
            return Kinshipcareprogram.updateprogram(request, _securityusersid);
        } else {
            return Kinshipcareprogram.addprogram(request, _securityusersid);
        }
    }

    Kinshipcareprogram.addprogram = function(request, _securityusersid)
    {
 
        return Kinshipcareprogram.create({
            intakeserviceid:request.intakeserviceid,
            programareakey:request.programareakey,
            subprogramareakey:request.subprogramareakey,
            startdate:request.startdate,
            enddate:request.enddate,
            insertedby:(request && request.securityuserid?request.securityuserid: _securityusersid),
            updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid)  
        }).then(data => {
            
            return data;
        })
        .catch(err => util.logError(err));
    }

    Kinshipcareprogram.updateprogram=(request, _securityusersid)=>{
     
        return Kinshipcareprogram.updateAll(
            {kinshipcareprogramid:request.kinshipcareprogramid},
            {
                intakeserviceid:request.intakeserviceid,
                programareakey:request.programareakey,
                subprogramareakey:request.subprogramareakey,
                startdate:request.startdate,
                enddate:request.enddate,
                updatedby:(request && request.securityuserid?request.securityuserid: _securityusersid)
        }).then(data => {
                    return "Program updated successfully";
                }).catch(err => util.logError(err));
        
    }
    Kinshipcareprogram.deleteprogram=(request, reqctx)=>{
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        return Kinshipcareprogram.updateAll(
            {kinshipcareprogramid:request.kinshipcareprogramid},
            {
                activeflag:0,
                updatedby:(request && request.securityuserid?request.securityuserid: _securityusersid)
        }).then(data => {
                    return "Deleted successfully";
                }).catch(err => util.logError(err));
        
    }
    Kinshipcareprogram.kinshipcarelist =(request)=>{
        var pageNumber = request.page;
        var pageLimit = request.limit;
		var sql = 'select * from getkinshipcareprogram($1,$2,$3)';
		return util.executeDBQuery(sql,[request.where.intakeserviceid,pageNumber,pageLimit])
		.then(data => {
			return data;
		})
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
    }
    Kinshipcareprogram.remoteMethod('addupdate', {
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
    Kinshipcareprogram.remoteMethod('deleteprogram', {
        http: {
                path: '/deleteprogram',
                verb: 'patch'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} , {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
        returns: {
            type : 'string',
            root : true
        }
    });
    Kinshipcareprogram.remoteMethod('kinshipcarelist', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			path: '/kinshipcarelist',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    
    Kinshipcareprogram.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Kinshipcareprogram.observe('access', (ctx, next) => util.access(ctx, next));
    Kinshipcareprogram.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};