'use strict';
const LOGGER = require("log4js").getLogger("investigationallegation");
const app = require('../../server/server');
const util = require('../utils/utils');
var config = require('../../server/config.json');

module.exports = Investigationallegation => {

    Investigationallegation.remoteMethod(
        'deleteAllegation',
            {
                http: {
                        path: '/deleteallegation/:id',
                        verb: 'delete'
                },
                accepts : [ {
                arg: 'id',
                type: 'string',
                required: true,
                http: {source: 'path'}
            },
            {
                arg: 'reqctx',
                type: 'object',
                http: {
                  source: 'context'
                }
            },
            {
                arg : 'data',
                type : 'object',
                required : true,
                http : { source: 'body' }
            }],

            returns: {
                type : 'object',
                root : true
            }

    });

    Investigationallegation.deleteAllegation = (id, request, reqctx) => {
        let iaaId = '';
        if(request) {
            iaaId = request.investigationallegationactorid;
        }

        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  

        var prs = [];
        if(!iaaId || iaaId === '') {
            prs.push(app.models.Investigationallegationactor.updateAll({investigationallegationid: id}, {activeflag: 0, updatedby: request && request.securityuserid?request.securityuserid: _securityusersid}));
            prs.push(Investigationallegation.updateAll({investigationallegationid: id}, {activeflag: 0, updatedby: request && request.securityuserid?request.securityuserid: _securityusersid}));
        }
        else
        {
            prs.push(app.models.Investigationallegationactor.updateAll({investigationallegationactorid: iaaId}, {activeflag: 0, updatedby: request && request.securityuserid?request.securityuserid: _securityusersid}));
        }
        return Promise.all(prs).then(data => data).catch(err => util.logError(err));
    };

    Investigationallegation.remoteMethod('addActors', {
        accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        },{
            arg : 'data',
            type : 'object',
            required : true,
            http : { source: 'body' }
        }],
        http: {verb: "post", path: "/addActors/:id"},
        returns : {
        type : 'Object',
        root : true
        }
    });

    Investigationallegation.addActors = (id, request) => {
        const data = request.data;
        const prs = [];
        prs.push(
            app.models.Investigationallegationactor.updateAll({investigationallegationid: id}, {activeflag: 0})
        );

        prs.push(
            data.filter(x => x.investigationallegationactorid)
            .map(iaactor => {
                var sql = 'Update investigationallegationactor set activeflag = 1 where investigationallegationactorid = $1';
                var params = [iaactor.investigationallegationactorid];

                return util.executeDBQuery(sql, params);
            }
        ));
        data.filter(x => !x.investigationallegationactorid).forEach(x => x.investigationallegationid = id);
        prs.push(
            data.filter(x => !x.investigationallegationactorid)
            .map(iaactor => {
                return app.models.Investigationallegationactor.create(iaactor);
            })
        );
        var flatPrs = prs.reduce((a,b) => a.concat(b), []);
        return Promise.all(flatPrs)
        .then(resp => {
            if(resp.length>0)
                {return resp[resp.length-1]}
            return resp;

        })
        .catch(err => {
            return util.logError(err);
        });
    };

    Investigationallegation.remoteMethod('actorList', {
        accepts : [
            {
                arg: 'id',
                type: 'string',
                required: true,
                http: {source: 'path'}
            },
        {
            arg : 'filter',
            type : 'object',
            required : true,
            http : { source: 'query' }
        }
        ],
        http: {"verb": "get", "path": "/actorList/:id"},
        returns : {
        type : 'Object',
        root : true
        }
    });

    Investigationallegation.actorList = (id,request) => {
        const investigationallegationid = id;
        const intakeserviceid = request.where.intakeserviceid;

        let isrActors, iaActors, isrActorsCount;

		const indiskip = (request.page - 1) * request.limit;
		const indilimit = request.limit;

		const prs = [];

        prs.push(app.models.Investigationallegationactor.find({
			where: {
                and: [{activeflag: true},
                    {investigationallegationid: investigationallegationid}
                ]
			},
			fields: ['investigationallegationactorid','intakeservicerequestactorid'],
			order: 'intakeservicerequestactorid',
			skip: indiskip,
			limit: indilimit
        }));
        prs.push(app.models.Intakeservicerequestactor.find({
			where: {
                and: [
                    {activeflag: true},
                    {intakeserviceid: intakeserviceid}
                ]
			},
			fields: ['intakeservicerequestactorid','actorid'],
			order: 'intakeservicerequestactorid',
			skip: indiskip,
            limit: indilimit,
            include: {
                relation: 'actor',
                scope: {
                    fields: ['actorid', 'personid','actortype'],
                    where: {
                        and: [
                            {activeflag: true},
                            {actortype: 'AP'}
                        ]
                    },
                    include: {
                        relation: 'Person',
                        scope: {
                            fields: ['firstname', 'lastname', 'middlename'],
                            where: {activeflag: 1}
                        }
                    }
                }
            }
		}));
		if(request.page == 1) {
			prs.push(app.models.Intakeservicerequestactor.find({
                where: {
                    and: [
                        {activeflag: true},
                        {intakeserviceid: intakeserviceid}
                    ]
                },
                fields: ['intakeservicerequestactorid','actorid'],
                include: {
                    relation: 'actor',
                    scope: {
                        fields: ['actorid'],
                        where: {
                            and: [
                                {activeflag: true},
                                {actortype: 'AP'}
                            ]
                        }
                    }
                }
            }));
		}
        return Promise.all(prs)
		.then(data => {
            iaActors = data[0].map(x=>x.__data);
            isrActors = data[1].map(x=>x.__data).filter(isrActor => isrActor.actor);
            isrActorsCount = 0;
            if(data.length==3) {
                isrActorsCount = data[2].map(x=>x.__data).filter(isrActor => isrActor.actor).length;
            }
            isrActors.forEach(isrActor => {
                isrActor.isAdded = iaActors.map(x => x.intakeservicerequestactorid).indexOf(isrActor.intakeservicerequestactorid) !== -1? true: false;
                const iaaIds = iaActors.filter(x => x.intakeservicerequestactorid == isrActor.intakeservicerequestactorid);
                isrActor.investigationallegationactorid = iaaIds.length > 0? iaaIds[0].investigationallegationactorid: null;

            });

			if(request.page != 1)
                {return isrActors;}
			else {
                return {
                    data: isrActors,
                    count: isrActorsCount
                }
            }
		})
       .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
	};

    //to add actorid in IntakeServiceRequestActor
    //actorid to get from link ap

    Investigationallegation.remoteMethod('allegationList', {
        accepts : [{
            arg : 'filter',
            type : 'object',
            required : true,
            http : { source: 'query' }
        }],
        http: {"verb": "get", "path": "/allegationList"},
        returns : {
        type : 'Object',
        root : true
        }
    });

    Investigationallegation.allegationList = data => {
        const investigationid = data.where.investigationid;

        const prs = [];
        prs.push(app.models.Allegation.allegationWOIndicatorsList(data));

        prs.push(Investigationallegation.find({
            where: {
                and: [
                    {activeflag: true},
                    {investigationid: investigationid}
                ]
            },
            fields: ['allegationid']
        }));

        return Promise.all(prs)
        .then(_data => {
            const allegationsList = _data[0].map(x => x.__data);

            if (_data.length>1) {
                const iaList = _data[1].map(x => x.__data);
                return allegationsList.filter(al => iaList.map(x => x.allegationid).indexOf(al.allegationid) === -1);
            }

            return allegationsList;
        })
       .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Investigationallegation.observe('after save', function (ctx, next) {
        var description,intakeserviceid,referenceid,Servicerequestnumber,isnew,isedit,isdelete;
        var logJson ={
            "data": {
                "allegationname": "",
                "createdby": "",
                "createadon": ""
            }
        };
        var logtypekey = "AA";

		   if (ctx.isNewInstance) //CREATE
		   {
                  description = "'"+ctx.instance.name+"'"+" Allegation added to DA#";
				  app.models.Investigation.findOne({where : {investigationid:ctx.instance.Investigationid},
						  fields:['intakeserviceid']
					}).then(data =>{
                        intakeserviceid = data.intakeserviceid;
                        referenceid = ctx.instance.investigationallegationid;
                        isnew = true;
                        logJson.data.allegationname = ctx.instance.name
                        logJson.data.createdby=ctx.instance.insertedby;
                        logJson.data.createadon=ctx.instance.insertedon;

                         var newadd = {
                            "description":description,
                            "logtypekey":logtypekey ,
                            "intakeserviceid": intakeserviceid,
                            "referenceid": referenceid,
                            "servicerequestnumber":Servicerequestnumber,
                            "metadata":logJson,
                            "isnew":isnew,
                            "isedit":isedit,
                            "isdelete":isdelete
                        }
                        app.models.Auditlog.createlogdetails(newadd);
                        next();
                    })
           }else if (ctx.data !== null && ctx.data !==  undefined ){

                    isdelete = true;
                    logJson =  {
                        "data": {
                            "allegationname": "",
                            "updatedby": "",
                            "updatedon": ""
                        }
                    };
                            Investigationallegation.findOne({where :{investigationallegation:ctx.where.investigationallegationid},
                                fields:['investigationid','name'],
                                include:{
                                    relation:'investigation',
                                    scope:{
                                        fields:['investigationid','intakeserviceid']
                                    }
                                    }
                                }).then(res => {
                            LOGGER.debug(res + "data");
                            const respon = JSON.parse(JSON.stringify(res));
                            description = "'"+respon.name +"'"+" Allegation deleted from DA#";
                            intakeserviceid = respon.investigation.intakeserviceid;
                            logJson.data.allegationname  = respon.name;
                            referenceid = ctx.where.investigationallegationid;
                            logJson.data.updatedby = app.currentUser.email;
                            logJson.data.updatedon = ctx.data.updatedon;

                            var newadd = {
                                "description":description,
                                "logtypekey":logtypekey ,
                                "intakeserviceid": intakeserviceid,
                                "referenceid": referenceid,
                                "servicerequestnumber":Servicerequestnumber,
                                "metadata":logJson,
                                "isnew":isnew,
                                "isedit":isedit,
                                "isdelete":isdelete
                            }
                            app.models.Auditlog.createlogdetails(newadd);
                            next();
                        })
        }

 })

 Investigationallegation.getmaltreatmentfinding =(request)=>{
    var sql = 'select * from getmaltreatmentfinding($1)';
    return util.executeSecondaryNodeDBQuery(sql,[request.where.investigationid])
    .then(data =>{
        return data[0].getmaltreatmentfinding;
    })
   .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }

    Investigationallegation.remoteMethod('getmaltreatmentfinding', {
    	accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'Object',
			root : true
		}
  })


  Investigationallegation.getexpungedmaltreatmentfinding =(request)=>{
    var sql = 'select * from getmaltreatmentfinding_expunge($1)';
    return util.executeDBQuery(sql,[request.where.investigationid])
    .then(data =>{
        return data[0].getmaltreatmentfinding_expunge;
    })
    .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
    })
    }

    Investigationallegation.remoteMethod('getexpungedmaltreatmentfinding', {
    	accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'Object',
			root : true
		}
  })

Investigationallegation.getinvestigationallegation = function(request) {
    var sql = 'select * from getinvestigationallegation($1)';
    return util.executeSecondaryNodeDBQuery(sql,[request.where.investigationid])
        .then(data => {
            return data && data[0] && data[0].getinvestigationallegation 
            ? data[0].getinvestigationallegation 
            : [];
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
}


	Investigationallegation.remoteMethod ('getinvestigationallegation',{
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'Object',
			root : true
		}
	});

    Investigationallegation.getexpungedinvestigationallegation = function(request) {
        let sql = 'select * from getinvestigationallegation_expunge($1)';
        return util.executeDBQuery(sql,[request.where.investigationid])
            .then(data => {
                return data[0].getinvestigationallegation_expunge;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    }
    
    
        Investigationallegation.remoteMethod ('getexpungedinvestigationallegation',{
            accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                    source : 'query'
                }
            },
            http : {
                verb : 'get'
            },
            returns : {
                type : 'Object',
                root : true
            }
        });

    Investigationallegation.getInvestigationContributingFactor =(request)=>{
        var sql = 'select * from getInvestigationContributingFactor($1)';
        return util.executeDBQuery(sql,[request.where.personId])
        .then(data =>{
            return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        })
        }
    
        Investigationallegation.remoteMethod('getInvestigationContributingFactor', {
            accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                    source : 'query'
                }
            },
            http : {
                verb : 'get'
            },
            returns : {
                type : 'Object',
                root : true
            }
      })

    Investigationallegation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationallegation.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationallegation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
