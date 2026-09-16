'use strict';
const LOGGER = require("log4js").getLogger("actorrelationship");
const util = require('../utils/utils');

module.exports = function(Actorrelationship) {
    
    Actorrelationship.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        } 

        //@Simar: Flipping the person1id and person2id so that the relationship will be defined as in chessie migrated data
        //Changing the get method as well, such that when getting all the relationships of other people for a given person
        //will match that person as person2id instead of person1id that way all the relationships will be maintained
        var temppersonid = request.person1id;
        request.person1id = request.person2id;
        request.person2id = temppersonid;
        
        request.caregiverflag = (request.careGiverFlag === true ? 1: 0);

        var sql = 'select count(*) as cnt from actorrelationship where person1id=$1 and person2id=$2 and intakeservicerequestactorid=$3';
        return util.executeDBQuery(sql, [request.person1id,request.person2id,request.intakeservicerequestactorid]).then((data)=>{
            LOGGER.debug("Deba",data[0].cnt)
                    if(data[0].cnt==='0') {
                        LOGGER.debug("deba1",data[0].cnt)
                        request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
                        request.updatedby  = (request && request.securityuserid?request.securityuserid: _securityusersid);
                        return (Actorrelationship.create(request));
                      } else {
                        return (Actorrelationship.updaterelation(request, _securityusersid));
                      } 
        }).catch((error)=>{
            LOGGER.error(error); 
            return error;
        });
       
    };

    Actorrelationship.updaterelation = (request, _securityusersid) => {
        var dataObject ={
            relationshiptypekey: request.relationshiptypekey,
            person1id : request.person1id,
            person2id : request.person2id,
            caregiverflag: request.careGiverFlag,
            updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid)
        };
        return Actorrelationship.updateAll(
            {
                person1id : request.person1id,
                person2id : request.person2id,
            },
            dataObject
            ).then (data => {
                return data;
            })
    };


    Actorrelationship.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        returns: {
            type: 'object',
            root: true
        }
    });

Actorrelationship.getcaregiverdetail = (request) => {
        // Same two defects as getallcaregiversincase below: an unguarded filter
        // arg, and a sql declaration inside the guard that var-hoists out of it.
        var req_personid = request?.where?.personid;

        if (req_personid === undefined || req_personid === null) {
            return Promise.resolve([]);
        }

        const sql = ' SELECT * FROM getcaregiverlist($1)';
        return util.executeDBQuery(sql, [req_personid])
            .then(data => {
                if (data != null && data.length > 0) {
                    return data;
                }
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Actorrelationship.remoteMethod(
        'getcaregiverdetail', {
            http: {
                path: '/getcaregiverdetail',
                verb: 'get'
            },
            accepts: [{
                arg: 'filter',
                type: 'object',
                http: {
                    source: 'query'
                }
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );

    Actorrelationship.getallcaregiversincase = (request) => {
        // filter is optional and util.beforeremote never writes its defaults back
        // to ctx.args, so a call with no filter query param arrives as undefined.
        var req_personid = request?.where?.personid;

        // sql was declared inside the guard below. var hoists, so a request with
        // no personid did not skip the query -- it called executeDBQuery(undefined),
        // which trips the connector's 'sql must be a string' assertion and gets
        // reported as a bare 400. Skip the round trip instead.
        if (req_personid === undefined || req_personid === null) {
            return Promise.resolve([]);
        }

        const sql = ' SELECT * FROM getallcaregiversincase($1)';
        return util.executeDBQuery(sql, [req_personid])
            .then(caregiversincasedata => {
                if (caregiversincasedata != null && caregiversincasedata.length > 0) {
                    return caregiversincasedata;
                }
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Actorrelationship.remoteMethod(
        'getallcaregiversincase', {
            http: {
                path: '/getallcaregiversincase',
                verb: 'get'
            },
            accepts: [{
                arg: 'filter',
                type: 'object',
                http: {
                    source: 'query'
                }
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );
    Actorrelationship.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Actorrelationship.observe('access', (ctx, next) => util.access(ctx, next));
    Actorrelationship.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
