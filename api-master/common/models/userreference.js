'use strict';
const LOGGER = require("log4js").getLogger("userreference");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Userreference) {
    var Totalcount = 0;
    Userreference.addreference = (request,reqctx) =>{
      let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    var securityusersid = (request && request.securityuserid?request.securityuserid: suserid);
    return app.models.Userreference.findOne({
			where:{
			  objectid: request.objectid,
			  securityusersid:securityusersid,
			  objecttypekey:request.objecttypekey
			}
		}).then(res =>{
			LOGGER.debug(res + "res");
			if( res === null || res.length === 0 ){
                return Userreference.add(request,reqctx);
            }
            else
            {
                return Userreference.deletereference(request,reqctx);
            }
            
})
}   
	Userreference.add = (request,reqctx) =>{	
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        var securityusersid = (request && request.securityuserid?request.securityuserid: suserid);
            return Userreference.create({
                securityusersid: securityusersid,
                objectid: request.objectid,
                objecttypekey: request.objecttypekey,
                casenumber: request.casenumber,
                legalguardian: request.legalguardian,
                worker: request.worker,
                insertedby: (request && request.securityusersid? request.securityusersid: suserid),
                updatedby: (request && request.securityusersid? request.securityusersid: suserid)
    }).then (data =>{
        return "Selected case - "+ request.casenumber + " tagged successfully";

    }).catch(err => util.logError(err));
} 

Userreference.deletereference = (request,reqctx) =>{
  let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
  var casenumber = request.casenumber;
  var securityusersid = (request && request.securityuserid?request.securityuserid: suserid);
  
    var filter = {
        where: {
          objectid: request.objectid,
          securityusersid: securityusersid,
          objecttypekey: request.objecttypekey,
        }
     };
  return Userreference.destroyAll(filter.where)
  .then(res => {
            return  "Selected case - "+ casenumber + " untagged successfully";
      })
  } 
                                                       

  Userreference.remoteMethod('addreference', {
    http: {
            path: '/addreference',
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
    
Userreference.beforeRemote('listuserreference', function(ctx, data, next) {
    let suserid = undefined;
    if(ctx && ctx.req && ctx.req.headers && ctx.req.headers.securityusersid){
      suserid = ctx.req.headers.securityusersid
    } 
    Userreference.count({securityusersid:(data && data.securityuserid?data.securityuserid: suserid)},function(err, count) {
        if (err) {
            throw err;
        }
        Totalcount = count;
    });
    next();
});

    Userreference.listuserreference = (request,reqctx) => {
      let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
        var securityusersid = (request && request.securityuserid?request.securityuserid: suserid);
        var result;
		return Userreference.find({
		        fields: ['userreferenceid','securityusersid','objectid','objecttypekey','casenumber','legalguardian','worker','receiveddate'],
                where:{
                and: [{activeflag:1},{securityusersid:securityusersid}]
                },
             order: 'insertedon desc',
			skip: request.skip,
			limit: request.limit,
		}).then(resp => { 
                result = {
                    'data': resp,
                    'count': Totalcount
                  }; 
                 return  result;  
			}).catch(err => util.logError(err));
    };
    Userreference.remoteMethod('listuserreference', {
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
          path: '/listuserreference',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });

    Userreference.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userreference.observe('access', (ctx, next) => util.access(ctx, next));
    Userreference.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
