'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(AdoptionCaseagreement) {

    module.exports.updateTable = (request) => {
        return new Promise( (resolve, reject) => {
             AdoptionCaseagreement.update({adoptionagreementid:request.adoptionagreementid}, request);
            resolve('success');
        })
    }
    
    AdoptionCaseagreement.remoteMethod('list', {
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
    
    AdoptionCaseagreement.list = request =>{
        var pageno = request.page;
        var pagesize = request.limit;

        const sql = 'select * from getadoptioncaseagreementlist($1, $2, $3)';
        return util.executeDBQuery(sql, [request.where.adoptioncaseid, pageno, pagesize])
        .then(resp => resp)
        .catch(err => err);
    }

    AdoptionCaseagreement.remoteMethod('add', {
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

    //---New methods start
    AdoptionCaseagreement.add = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var status = request.statustypeid;
        var sql = 'select * from adoptioncaserouting($1,$2,$3,$4,$5)';

        return util.executeDBQuery(sql, [request.adoptioncaseid, request.adoptioncaseagreementid, securityusersid, 'ASAR', status])
        .then( res => {
            return AdoptionCaseagreement.processafterAddingAgreement(request, _securityusersid).then(data => {
                return data;
            }).catch(err => util.logError(err));
        });
    }

    AdoptionCaseagreement.remoteMethod('routeagreement', {
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
    
    AdoptionCaseagreement.routeagreement = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var status = request.statustypeid;
        var sql = 'select * from adoptioncaserouting($1,$2,$3,$4,$5)';

        return util.executeDBQuery(sql, [request.adoptioncaseid, request.adoptioncaseagreementid, securityusersid, 'ASAR', status]);
    }
    //--new methods end

    AdoptionCaseagreement.processafterAddingAgreement = (request, _securityusersid) => {
        var adoptionagreementid;
        adoptionagreementid = request.adoptionagreementid;
        const response = [];
        // Added document upload function for AdoptionCaseagreement
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

    AdoptionCaseagreement.remoteMethod('printAdoptionDocument', {
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

    AdoptionCaseagreement.printAdoptionDocument = function(request) {
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
    
    AdoptionCaseagreement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    AdoptionCaseagreement.observe('access', (ctx, next) => util.access(ctx, next));
    AdoptionCaseagreement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};