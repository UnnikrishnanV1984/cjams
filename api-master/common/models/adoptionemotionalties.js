'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Adoptionemotionalties) {
    

    Adoptionemotionalties.addupdate =(request, reqctx)=>{
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
     if(request.emotionaltieid === undefined || request.emotionaltieid === null)
      {
         return  Adoptionemotionalties.create({

            fmprefixtypekey:request.fmprefixtypekey,
            fmfirstname:request.fmfirstname,
            fmmiddlename:request.fmmiddlename,
            fmlastname:request.fmlastname,
            fmsuffixtypekey:request.fmsuffixtypekey,
            relationshiptochildtx:request.relationshiptochildtx,
            importancetochildtx:request.importancetochildtx,  
            providerid:request.providerid, 
            adoptionplanningid:request.adoptionplanningid,                  
            insertedby: (request && request.v_securityusersid ? request.v_securityusersid : _securityusersid),
            updatedby: (request && request.v_securityusersid ? request.v_securityusersid : _securityusersid)            
            })
        }
        else
        {
            return  Adoptionemotionalties.updateAll(
                { emotionaltieid:request.emotionaltieid},
                {
                    fmprefixtypekey:request.fmprefixtypekey,
                    fmfirstname:request.fmfirstname,
                    fmmiddlename:request.fmmiddlename,
                    fmlastname:request.fmlastname,
                    fmsuffixtypekey:request.fmsuffixtypekey,
                    relationshiptochildtx:request.relationshiptochildtx,
                    importancetochildtx:request.importancetochildtx,  
                    providerid:request.providerid, 
                    adoptionplanningid:request.adoptionplanningid,                                   
                    updatedby:(request && request.securityuserid?request.securityuserid: _securityusersid)     
                }
                )
              }
    }

    
    Adoptionemotionalties.remoteMethod(
        'addupdate',
                {
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
                      type : 'object',
                        root : true
                  }
                 }
    );

  
    Adoptionemotionalties.remoteMethod('list', {
        http: {
            path: '/list',
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

    Adoptionemotionalties.list =(request)=> {

        var adoptionplanningid = request.where.adoptionplanningid;

        var sql = 'select * from getadoptionemotionalties($1)';

		return util.executeDBQuery(sql, [adoptionplanningid])
		.then(datas => datas)
		.catch(err => util.logError(err));
    };

	Adoptionemotionalties.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionemotionalties.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionemotionalties.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
