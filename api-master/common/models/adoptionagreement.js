'use strict';
const LOGGER = require("log4js").getLogger("adoptionagreement");
const util = require('../utils/utils');
var app = require('../../server/server');
var fs = require('fs');
const AdoptionCaseagreement = require('../models/adoptioncaseagreement');

module.exports = function(Adoptionagreement) {
    Adoptionagreement.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    
    Adoptionagreement.list = (request) => {
        var pageno = request.page;
        var pagesize = request.limit;

            const sql = 'select * from getadoptionagreementlist($1, $2, $3)';
        return util.executeSecondaryNodeDBQuery(sql, [request.where.adoptionplanningid, pageno, pagesize])
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }

    Adoptionagreement.remoteMethod('add', {
        http: {
            path: '/add',
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

    Adoptionagreement.remoteMethod('getbioclientid', {
        accepts: {
          arg: 'clientid',
          type: 'number',
          http: {
            source: 'path'
          },
          required: true
        },
        http: {
          verb: 'get',
          path: '/getbioclientid/:clientid'
        },
        returns: {
          type: 'array',
          root: true
        }
      });
      
    Adoptionagreement.getbioclientid = (clientid) => {
        const sql = 'SELECT * FROM get_client_eligibility_data($1)';
        return util.executeDBQuery(sql, [clientid])
            .then(data => data)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    //---New methods start
    Adoptionagreement.add = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var status = request.statustypeid;
        var sql = 'select * from adoptionrouting($1,$2,$3,$4,$5)';

        return util.executeDBQuery(sql, [request.servicecaseid, request.adoptionagreementid, securityusersid, 'ASAR', status])
        .then( res => {
            return Adoptionagreement.processafterAddingAgreement(request, _securityusersid).then(data => {
                return data;
            }).catch(err => util.logError(err));
        }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Adoptionagreement.remoteMethod('routeagreement', {
        http: {
                path: '/routeagreement',
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
    
    Adoptionagreement.routeagreement = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var status = request.statustypeid;
        var sql = 'select * from adoptionrouting($1,$2,$3,$4,$5)';

        return util.executeDBQuery(sql, [request.servicecaseid, request.adoptionagreementid, securityusersid, 'ASAR', status])
            .then(data => data)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    }
    //--new methods end
    Adoptionagreement.remoteMethod('saveAsDraft', {
        http: {
            path: '/saveAsDraft',
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

    Adoptionagreement.saveAsDraft = function(request, reqctx) {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        } 
        request.securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        if (request.adoptionagreementid == null || request.adoptionagreementid === undefined 
            || request.isPrivateAdoption) {
            return Adoptionagreement.create(request);
        } else {
            return Adoptionagreement.update(
                { adoptionagreementid: request.adoptionagreementid },
                { request }
            );
        }
    }

    Adoptionagreement.processafterAddingAgreement = (request, _securityusersid) => {
        var adoptionagreementid;
        adoptionagreementid = request.adoptionagreementid;
        const response = [];
        // Added document upload function for adoptionagreement
        if (request.attachment != null && request.attachment !== undefined && request.attachment !== "") {
            request.attachment.map(attach => {
                attach.objectid = adoptionagreementid;
                attach.objecttypekey = 'AdoptionSubsidy';
                attach.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
                attach.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
                response.push( app.models.Documentproperties.addattchment(attach));
            });
        }
        return Promise.all(response);
    }

    Adoptionagreement.printAdoptionDocument = function(request) {
        return new Promise((resolve, reject) => {
            var filename;            
            if(request.where.refkey === 'SAAA') {
                filename = 'State Adoption Assistance Agreement.pdf'
            } else if(request.where.refkey === 'SAAAR') {
                filename = 'State Adoption Assistance Agreement Redetermination.pdf'
            } else if(request.where.refkey === 'PASRF') {
                filename = 'Post Adoption Services Referral Form.pdf'
            } else if(request.where.refkey === 'PAAA') {
                filename = 'Post Adoption Assistance Agreement.pdf'
            } else if(request.where.refkey === 'OTOAA') {
                filename = 'One-Time-Only Adoption Agreement.pdf'
            } else if(request.where.refkey === 'IVEAAA') {
                filename = 'IV-E Adoption Assistance Agreement.pdf'
            } else if(request.where.refkey === 'IVEAAAR') {
                filename = 'IV-E Adoption Assistance Agreement Redetermination.pdf'
            }

            var filepath = './documenttemplates/assets/' + filename;
            fs.readFile(filepath, function (err, data) {
                if (err) {reject(err);}
                else {resolve(data);}
            });
        });
    }

    Adoptionagreement.remoteMethod('printAdoptionDocument', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

    Adoptionagreement.remoteMethod('getparentnames', {
		accepts : { arg : 'filter',
                    type : 'Object',
                    http : { source : 'query' },
                    required : true
		},
		http : { verb : 'get' },
        returns : { type : 'string',
            root : true
		}
	});
    
    Adoptionagreement.getparentnames = request =>{
        const sql = 'select * from getadoptiveparents($1)';
        return util.executeDBQuery(sql, [request.where.providerid])
        .then(resp => resp)
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }
    
    Adoptionagreement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionagreement.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionagreement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}  
