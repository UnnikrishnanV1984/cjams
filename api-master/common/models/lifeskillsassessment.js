'use strict';

const LOGGER = require("log4js").getLogger("lifeskillsassessment");
var app = require('../../server/server');
const util = require('../utils/utils');
var SmartyStreets = require('smartystreets-api');
var actordesc ; // Added for audit log
const dateTime = require('date-time');
var config = require('../../server/config.json');

module.exports = function(Lifeskillsassessment){

    /** Start Remote Create Record **/
    Lifeskillsassessment.remoteMethod(
        'create',
        {
        accepts: [{arg: 'data', type: 'object', http: { source: 'body' }}],
        returns: {type: 'object', root: true}
        }
    );
    /** End Remote Create Record **/

    Lifeskillsassessment.remoteMethod('addupdate',{
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
    });

    Lifeskillsassessment.addupdate = (request, reqctx) => {       
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        if(request.lifeskillassessid== null || request.lifeskillassessid == undefined)
        {
           var addreq = {

                personid:request.personid,
                assessmenttypekey:request.assessmenttypekey,
                assessmentlocation:request.assessmentlocation,
                assessmentdate:request.assessmentdate,
                fk_id: 'CW',
                old_id: '',                   
                inserted_by:(request && request.securityuserid?request.securityuserid: _securityusersid),
                insertedon:    new Date().toLocaleString()           
    
            }
            return Lifeskillsassessment.create(addreq).then(data => {
               return data;
        })
    }
        else
        {
             return Lifeskillsassessment.updateAll(
            {lifeskillassessid:request.lifeskillassessid},
            {
                personid:request.personid,
                assessmenttypekey:request.assessmenttypekey,
                assessmentlocation:request.assessmentlocation,
                assessmentdate:request.assessmentdate,
                fk_id: 'CW',
                old_id: '',   
                updatedon: new Date().toLocaleString(),                                   
                updated_by:(request && request.securityuserid?request.securityuserid: _securityusersid)
                
        }).then(res=>{
            return  request;
        }).catch(err => util.logError(err));
        }     
    }

    Lifeskillsassessment.remoteMethod('delete', {
        http: { 
                path: '/delete/:id',
                verb: 'delete'
              },
		accepts:
			  {
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			  },
        returns: 
             {
			    type: 'Object',
			    root: true
		     }
    });
    
    Lifeskillsassessment.delete = (id) => {
		var sql = 'update personlifeskillassessment set activeflag = 0 WHERE lifeskillassessid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .then(data => data)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };
    
    Lifeskillsassessment.remoteMethod('list', {
        http: {
              path: '/list',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
    });
    
    Lifeskillsassessment.list = request => {
        var v_personid = request.where.personid;
        var sql = 'select * from personlifeskillassessmentlist($1,$2,$3)';
		return util.executeSecondaryNodeDBQuery(sql, [v_personid,request.page,request.limit])
		.then(datas => datas)
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Lifeskillsassessment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Lifeskillsassessment.observe('access', (ctx, next) => util.access(ctx, next));
    Lifeskillsassessment.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};