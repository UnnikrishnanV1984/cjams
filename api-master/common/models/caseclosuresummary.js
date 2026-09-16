'use strict';
const LOGGER = require("log4js").getLogger("caseclosuresummary");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Caseclosuresummary) {

    // caseclosuresummaryid and intakeserviceid are both uuid columns. A non-uuid
    // value is bound as text, so Postgres rejects the statement with 22P02 invalid
    // input syntax for type uuid before matching a row, and error-logger rewrites
    // every failure to statusCode 400 -- so it reaches APM as a bare "HttpError
    // 400, No stack trace" against the plain /api/caseclosuresummary path. Callers
    // build these ids from route params and data-store lookups, so reject a
    // malformed one here with a message that names the field.
    const UUID_PATTERN = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

    function notAUuid(id) {
        return typeof id !== 'string' || !UUID_PATTERN.test(id.trim());
    }

    // Only guards a value the caller actually supplied: an absent key is a
    // legitimate "match anything" and juggler leaves it out of the where clause.
    // An explicit null is rejected too -- juggler turns that into IS NULL, which is
    // valid SQL rather than 22P02, but it only ever means the caller failed to
    // resolve an id, and intakeserviceid is NOT NULL so it cannot match anyway.
    function uuidFilterError(where, field) {
        if (where?.[field] === undefined) {
            return null;
        }
        if (notAUuid(where[field])) {
            const err = new Error(field + ' must be a uuid');
            err.statusCode = 400;
            err.code = 'INVALID_ID';
            return err;
        }
        return null;
    }

    // The bare model path is the built-in PersistedModel find, so there is no
    // custom method to guard -- hook the remote instead.
    Caseclosuresummary.beforeRemote('find', (ctx, unused, next) => {
        const filter = ctx.args.filter;
        const where = filter ? filter.where : null;
        const err = uuidFilterError(where, 'intakeserviceid') ||
            uuidFilterError(where, 'caseclosuresummaryid');
        return next(err || undefined);
    });

     Caseclosuresummary.remoteMethod('addupdate', {
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


    
    Caseclosuresummary.addupdate = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;  
        const _vsecurityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid;  
        if(request.caseclosuresummaryid !== undefined && request.caseclosuresummaryid !== null) {
            return Caseclosuresummary.updateclosure(request, _securityusersid, _vsecurityusersid);
        } else {
            return Caseclosuresummary.addclosure(request, _securityusersid, _vsecurityusersid);
        }
    }
    /* Case Closure Summary Add Update */
    Caseclosuresummary.addclosure =(request, _securityusersid, _vsecurityusersid)=>{  
        var participants = request.participants;
        var interventionissues = request.interventionissues;
        LOGGER.debug('interventionissues 22222222222'+interventionissues);
        const prs =[];
        var v_caseclosuresummaryid;
        return Caseclosuresummary.create({
            intakeserviceid:request.intakeserviceid,
            reason:request.reason,
            referralreason:request.referralreason,
            riskissues:request.riskissues,
            insertedby: _securityusersid,
            updatedby: _securityusersid,
            recommendation:request.recommendation,
            interventionissues:request.interventionissues,
            clientrefrdservices:request.clientrefrdservices,
            closuretypekey:request.closuretypekey,
            closuresubtypekey:request.closuresubtypekey,
            notes:request.notes
        })
        .then(res =>{
            var resp = JSON.parse(JSON.stringify(res)); //what you are trying to do?  

            v_caseclosuresummaryid = resp.caseclosuresummaryid;
            // need to add caseclosuresummaryid to request
            request.caseclosuresummaryid = resp.caseclosuresummaryid;
            if(Array.isArray(participants)) {
                participants.forEach(element => {
                    prs.push(
                        app.models.Caseclosureparticipant.create({
                            caseclosuresummaryid:v_caseclosuresummaryid,
                            intakeservicerequestactorid:element.intakeservicerequestactorid,
                            ischild:element.ischild,
                            insertedby: _securityusersid,
                            updatedby: _securityusersid
                        })
                    )
                })                    
            }
            if(Array.isArray(interventionissues)) {
                interventionissues.forEach(element => {
                     prs.push(
                        app.models.Caseclosureservice.create({
                            caseclosuresummaryid:v_caseclosuresummaryid,
                            interventiontypekey:element,
                            insertedby: _vsecurityusersid,
                            updatedby: _vsecurityusersid
                        })
                    )
                })                    
            }
            if(request.isapprove)
            {
            prs.push( Caseclosuresummary.arRouting(request, _securityusersid));
            }
            return Promise.all(prs);
        }).then(data => {
            var responseJson = {};
            responseJson.intakeserviceid=request.intakeserviceid;
            responseJson.caseclosuresummaryid=v_caseclosuresummaryid;
            responseJson.disableArSummary = true;
            return responseJson;
        }).catch(err => { 
            LOGGER.debug("******** ERROR "+ err);
        util.logError(err)
     });
    }
    

    Caseclosuresummary.arRouting = (request, _securityusersid)=>{
		var userid = _securityusersid;
		var status = 15;
		var isservicecase = 0;
		request.comments = 'Comments';
        var nofitymsg = 'AR Summary Submitted for review';
        var ismanual= true;
        var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
        
        if (request.arStatus.toLowerCase() == "rejected") {
			status = 17;
            nofitymsg = 'AR Summary Rejected ';
            ismanual= false;
		}
		else if (request.arStatus.toLowerCase() == "accepted") {
			status = 16;
            nofitymsg = 'AR Summary Approved ';
            ismanual= false;

		}

        LOGGER.debug("Looking for this ************************** starts")
        //
		const reqParams = [request.caseclosuresummaryid, userid, 'ARSM', status, request.comments, request.assignsecurityuserid, ismanual, false, false, nofitymsg,'',request.intakeserviceid,'',isservicecase];
		reqParams.forEach(
			(item)=>{
				LOGGER.debug(item)
			}
		)
		LOGGER.debug("Looking for this ************************** Ends")

		return util.executeDBQuery(sql, [request.caseclosuresummaryid, userid, 'ARSM', status, request.comments, request.assignsecurityuserid, ismanual, false, false, nofitymsg,'',request.intakeserviceid,'',isservicecase])
		.then(data => data)
		.catch(err => {
			LOGGER.debug("Error in Routing for ar summary",err);
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
		
		

    }




    Caseclosuresummary.updateclosure =(request, _securityusersid, _vsecurityusersid)=>{  
        var participants = request.participants;
        var interventionissues = request.interventionissues;
        LOGGER.debug('interventionissues 111111'+interventionissues);
        const prs =[];
        return Caseclosuresummary.updateAll(
            {caseclosuresummaryid:request.caseclosuresummaryid},
            {
            intakeserviceid:request.intakeserviceid,
            reason:request.reason,
            referralreason:request.referralreason,
            riskissues:request.riskissues,
            recommendation:request.recommendation,
            interventionissues:request.interventionissues,
            clientrefrdservices:request.clientrefrdservices,
            closuretypekey:request.closuretypekey,
            closuresubtypekey:request.closuresubtypekey,
            closuredate:request.closuredate,
            notes:request.notes   
            }).then(resp => {
                var sql = 'select * from updateclosuresummary($1)';
                return util.executeDBQuery(sql, [request.caseclosuresummaryid]);
            }).then(result =>{
                if(Array.isArray(participants)) {
                    participants.forEach(element => {
                       prs.push(
                            app.models.Caseclosureparticipant.create({
                                caseclosuresummaryid:request.caseclosuresummaryid,
                                intakeservicerequestactorid:element.intakeservicerequestactorid,
                                ischild:element.ischild,
                                insertedby: _vsecurityusersid,
                                updatedby: _vsecurityusersid
                            })
                        )
                    })                        
                }  
                if(Array.isArray(interventionissues)) {
                    interventionissues.forEach(element => {
                            prs.push(
                            app.models.Caseclosureservice.create({
                                caseclosuresummaryid:request.caseclosuresummaryid,
                                interventiontypekey:element,
                                insertedby: _securityusersid,
                                updatedby: _securityusersid
                            })
                        )
                    })                    
                } 
                //prs.push( Caseclosuresummary.arRouting(request))
                if(request.isapprove)
                {
                prs.push( Caseclosuresummary.arRouting(request, _securityusersid));
                }
                return Promise.all(prs);
            }).then(data => {
            var responseJson = {};
            responseJson.intakeserviceid=request.intakeserviceid;
            responseJson.caseclosuresummaryid=request.caseclosuresummaryid;
            responseJson.disableArSummary = true;
            return responseJson;
        }).catch(err => util.logError(err));
        }

       
	
    Caseclosuresummary.remoteMethod('validatecaseclosurelist', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			path: '/validatecaseclosurelist',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    

     /*  Validating assessment, checklist are closed  */

    Caseclosuresummary.validatecaseclosurelist =(request)=>{
		var sql = 'select * from validatecaseclosure($1)';
		return util.executeSecondaryNodeDBQuery(sql,[request.where.intakeserviceid]).then((data)=>{
			return data[0].validatecaseclosure;
		}).catch((err)=>{ LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
    }


    Caseclosuresummary.remoteMethod('caseclosuresummarylist', {
		accepts : {
			arg : 'data',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			path: '/caseclosuresummarylist',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });

    Caseclosuresummary.caseclosuresummarylist = data => {
        

        return Caseclosuresummary.find({where : data.where}).then(
			result =>{
				var item = result[0];
				LOGGER.debug("Calling caseclosuresummarylist******"+item);
				return Promise.resolve(item);
			}

        ).then(res=>{
            
            if(res){
                var sql = 'select routingstatustypeid from routing where objectid =$1 and routingstatustypeid in (\'15\',\'16\',\'17\') and activeflag = 1 and eventcode = \'ARSM\'  order by updatedon desc';
              return util.executeSecondaryNodeDBQuery(sql, [res.caseclosuresummaryid])
              .then(_data=>{
                if(_data && _data.length > 0){
                    res.routingstatustypeid = _data[0]["routingstatustypeid"];
                    res.disableArSummary = true;
                }else{
                    res.disableArSummary = false;
                }
                return res;
              })
              .then(_res => _res)
              .catch(err=>{
				LOGGER.error('>>>>ERROR:', err);
              })

            }else{
                return res;
            }
            });
    };



    Caseclosuresummary.updatedisposition = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}

        const sql1 = 'select * from createdisposotiononcaseclosure($1,$2,$3,$4)';

        return util.executeDBQuery(sql1, [request.where.intakeserviceid,request.where.intakeserreqstatustypeid,request.where.dispostionid,(request && request.securityuserid?request.securityuserid: _securityusersid)]);
     };

     Caseclosuresummary.remoteMethod('updatedisposition', {
       http: {
             path: '/updatedisposition',
             verb: 'get'
       },
      accepts : [{
         arg : 'filter',
         type : 'object',
         http : {source : 'query'}
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
       returns: {
           type : 'object',
             root : true
       }
     });

     
    Caseclosuresummary.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Caseclosuresummary.observe('access', (ctx, next) => util.access(ctx, next) );
    Caseclosuresummary.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}