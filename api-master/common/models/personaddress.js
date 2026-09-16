'use strict';
const LOGGER = require("log4js").getLogger("personaddress");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Personaddress) {

    Personaddress.remoteMethod('addupdate', {
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

    Personaddress.remoteMethod('gethouseholdaddress', {
        http: {
                path: '/gethouseholdaddress',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Personaddress.remoteMethod('personaddressdelete', {
        http: { 
                path: '/personaddressdelete/:id',
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

    Personaddress.remoteMethod('list', {
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

    Personaddress.remoteMethod('list', {
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

      Personaddress.remoteMethod('updatecurrentaddress', {
        http: {
                path: '/updatecurrentaddress',
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

    Personaddress.updatecurrentaddress = function(request, reqctx){
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var securityuserid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var personaddressid = request.personaddressid;
        var sql = "select * from updatepersonaddresscurrentlocation($1,$2)"
        return util.executeDBQuery(sql, [personaddressid, securityuserid]).then(res => {
            return res;
        }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Personaddress.addupdate = function(request, reqctx) {   //NOSONAR
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;  
        var responsedata = '';
        const insertedon = new Date().toLocaleString();
        if(request.personaddressid === null || request.personaddressid === undefined)
        {
            request.updatedby = _securityusersid;
            request.insertedby = _securityusersid;
            return Personaddress.create(request).then(res => {
                return res;
            }).then(async (resp) => {
                var sql = 'SELECT * from sp_get_person_mdm_address($1)';
                return util.executeDBQuery(sql, [request?.personid]).then(async data => {
                    if(data && data[0]?.addresses?.length>0){
                        await app.models.Person.addPersonToMDM(data, _securityusersid, 'mdm_addupdate_address');
                    }
                    return resp;
                }).catch(err => {
                    LOGGER.error(err);
                    util.logError(err)
                });
            });
        }
        else
        {
            if(request.personadrenddate !== null && request.personadrenddate !== undefined){
                request.currentlocationflag=0;
            }
            return Personaddress.updateAll(
              {personaddressid:request.personaddressid},request).then(
                data => {
                    responsedata = data;
                        var personDes = '';
                    let sql = "select personDescription from  getpersonnameandid($1)"
                     return util.executeDBQuery(sql,[request.personid]).then(datas => {
                        personDes = datas[0].persondescription;
                        app.models.Auditlog.create({
                            logtypekey:'NY017',
                            intakeserviceid:null,
                            servicerequestnumber:null,
                            referenceid:null,
                            description:'Address information is modified for ' + personDes,
                            isnew :false,
                            isedit:true,
                            isdelete:false,
                            insertedby: _securityusersid,
                            updatedby: _securityusersid,
                            insertedon:insertedon,
                            updatedon:insertedon,
                            metadata:null,
                            ipaddress:null,
                            old_id:null,
                            modifieddata:null,
                            objectid:request.objectid,
                            objecttype:request.objecttype

                        }).catch(_err => LOGGER.error(_err));
                        return data;
                    });
                }
              ).then(res => {
            return responsedata
        }).then(async (resp) =>{        // NOSONAR
                var sql = 'SELECT * from sp_get_person_mdm_address($1)';
                return util.executeDBQuery(sql, [request?.personid]).then(async data => { // NOSONAR
                if(data && data[0]?.addresses?.length>0){
                    await app.models.Person.addPersonToMDM(data, _securityusersid, 'mdm_addupdate_address');
                }
                return resp;
            }).catch(err => {
                LOGGER.error(err);
                util.logError(err)
            });
        });
    }
};

    Personaddress.personaddressdelete = (id) => {
        var sql = 'update personaddress set activeflag = 0 WHERE personaddressid =\''+id+'\'';
        return util.executeDBQuery(sql, []).then(data => {
            return data;
        }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Personaddress.list = request => {
        let gPersonaddress = [];
        const personid  = request.where.personid;
        return Personaddress.find({
            where: {personid: personid},
            include: [{
                relation: 'Personaddresstype',
                scope: {
                    fields: ['personaddresstypekey', 'typedescription']
                }
            }]
        })
        .then(data => {
            gPersonaddress = JSON.parse(JSON.stringify(data));
            const prs = gPersonaddress.map(x => findStateByCode(x));
            return Promise.all(prs);
        })
        .then(data => data)
        .catch(err => util.logError(err));
      };

      function findStateByCode(personEdn) {
        return app.models.State.find({
            where: {stateabbr: personEdn.state},
            fields: ['statename']
        })
        .then(res => {
            const data = JSON.parse(JSON.stringify(res));
            if (data.length > 0){
                personEdn.statename = data[0].statename;}
            return personEdn;
        })
        .catch(err => util.logError(err));
    }
      

    Personaddress.gethouseholdaddress = function(request)
    {
        var personaddresstypekey = 'HO';
        var sql = "select * from personaddress where personid in (";
        if (request.objecttype === "servicerequest"){
            sql = sql + "select personid from actor where intakeserviceid = $1 and ishouseholdmember = 1";
        }else if (request.objecttype === "Intake"){
            sql = sql + "select personid from actor where intakenumber = $1";
        }else{
            sql = sql + "select personid from actor where servicecaseid = $1 and ishouseholdmember = 1";}
        sql = sql + ") and personaddresstypekey = $2 order by addressstartdate desc nulls last, personadrenddate desc nulls first limit 1";
        return util.executeDBQuery(sql, [request.objectid, personaddresstypekey]).then(datas => {
            return datas;
        }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Personaddress.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personaddress.observe('access', (ctx, next) => util.access(ctx, next));
    Personaddress.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
