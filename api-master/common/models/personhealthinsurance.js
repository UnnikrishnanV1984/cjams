'use strict';
const LOGGER = require("log4js").getLogger("personhealthinsurance");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function(Personhealthinsurance) {  

    Personhealthinsurance.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {
                  source: 'context'
                }
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Personhealthinsurance.remoteMethod('personhealthinsurancedelete', {
        http: { 
                path: '/personhealthinsurancedelete/:id',
                verb: 'delete'
              },
		accepts:
			  [{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			  },
              {
                arg: 'reqctx',
                type: 'object',
                http: {
                  source: 'context'
                }}],
        returns: 
             {
			    type: 'Object',
			    root: true
		     }
    });

    Personhealthinsurance.remoteMethod('listpersonhealthinsurance', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Personhealthinsurance.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
		
		request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
	  
        if(request.personhealthinsuranceid== null || request.personhealthinsuranceid == undefined)
        {
            return Personhealthinsurance.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personhealthinsurance.updateAll({personhealthinsuranceid:request.personhealthinsuranceid},request);
        }
    };

    Personhealthinsurance.personhealthinsurancedelete = (id,reqctx) => {
        let suserid=undefined;
        if(reqctx && reqctx.req &&reqctx.req.headers){
          suserid=reqctx.req.headers.securityusersid
        }
		var sql = 'update personhealthinsurance set updatedby = $1 , activeflag = 0, updatedon = now() WHERE personhealthinsuranceid = $2';
        return util.executeDBQuery(sql, [suserid, id])
        .then(data => {
            return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Personhealthinsurance.listpersonhealthinsurance = request => {
        const personid = request.where.personid;
        const pageno = request.page;
        const pagesize = request.limit;
        const sortcolumn = request.sortcolumn;
        const sortorder = request.sortorder;
          const sql = 'select * from listpersonhealthinsurance($1, $2, $3, $4, $5)';
          return util.executeSecondaryNodeDBQuery(sql, [personid, pageno, pagesize, sortcolumn, sortorder])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      };



      Personhealthinsurance.remoteMethod('list', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            verb: 'get'
        },
        returns: {
            type: 'string',
            root: true
        }
    });

    Personhealthinsurance.list = request => {
        const personid = request.where.personid;
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var limit = request.limit;
        var totalcount = 0;
        var sql = `select count(1) over() as totalcount,activeflag,address1,address2,caresauno,caresmatypekey,city,county,countyid, effectivedate,expirationdate,groupnumber,infoclienttypekey,insertedby
        insertedon,(select value_text from referencevalues where ref_key=insurancetype and referencetypeid=338 and activeflag=1 limit 1),insurancetype,isinsuranceavailable,(select value_tx from tb_picklist_values where picklist_type_id = '172' and active_sw = 'Y' and delete_sw = 'N' and trim(picklist_value_cd) = trim(phi.patientpolicyholderrelation) limit 1),ismedicaidmedicare, ismedicareprimary,managedcareorganization,medicaidenddate,medicaidstartdate,medicalinsuranceprovider,medicarenumber,patientpolicyholderrelation,
        personhealthinsuranceid,personid,policyholdername,policyname,policynumber,providedbynotes,providerphone,providertype,providertypeother,state,updatedby,updatedon,zip, (SELECT json_agg(docs) FROM  (
            SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon,(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
            dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
            (SELECT row_to_json(x) AS documentattachment FROM( SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
            (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat WHERE dat.documentpropertiesid = dp.documentpropertiesid ) x),dp.uploadstatus, dp.finalstatus,dp.ecmsdocumentid
            from documentproperties dp where dp.additionalobjectid = phi.personhealthinsuranceid::varchar and dp.additionalobjecttype = \'personhealthinsurance\' and dp.activeflag in (1,4,3,5) )docs) as uploadpath
         from personhealthinsurance phi where activeflag=1 and personid=$1`;
         
         const params = [personid];
         let paramIndex = 2;

         if(request.where.startDate){
           sql = sql + ` AND phi.insertedon >= DATE($${paramIndex})`;
            params.push(request.where.startDate);
            paramIndex++;
         }
         if(request.where.endDate){
            sql = sql + ` AND phi.insertedon <= DATE($${paramIndex}) + 1`;
            params.push(request.where.endDate);
            paramIndex++;
         }

         sql = sql + ` limit $${paramIndex} offset $${paramIndex + 1}`;
         params.push(limit, request.skip);

        return util.executeDBQuery(sql, params)
            .then(data => {
                if (data !== null && data.length > 0) {
                    totalcount = data[0].totalcount;
                }
                var result;
                result = {
                    'data': data,
                    'count': totalcount
                };
                return result;
            })
            .catch(err => LOGGER.error(err));
    }


    Personhealthinsurance.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personhealthinsurance.observe('access', (ctx, next) => util.access(ctx, next));
    Personhealthinsurance.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PHLTHINS',
    (ctx.isNewInstance || (ctx.instance && ctx.instance.personid)) ? ctx.instance.personid : ctx.where.personid));
    Personhealthinsurance.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}