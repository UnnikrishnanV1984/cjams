'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestevaluation");
const util = require('../utils/utils');
let app = require('../../server/server');

module.exports = function(Intakeservicerequestevaluation) {

    Intakeservicerequestevaluation.isComplaintIdExists = request => {
        let countyid = '';
        let complaintid = '';
        let isExists = false;
        const emptyUUID = '00000000-0000-0000-0000-000000000000';
        let intakeserreqstatustypeid = emptyUUID;
        let isrEvals = [];
        let crossRefs = [];

        if(request.where) {
            countyid = request.where.countyid;
            complaintid = request.where.complaintid;
        }
        
        var prs = [];
        prs.push(app.models.Intakeserreqstatustype.findOne({
            fields: ['intakeserreqstatustypeid'],
            where: {intakeserreqstatustypekey: 'Rejected'}
        }));

        prs.push(Intakeservicerequestevaluation.count({
                and: [
                    {countyid: countyid},
                    {complaintid: complaintid}
                ]
        }));
        return Promise.all(prs)
        .then(res => {
            const data = JSON.parse(JSON.stringify(res));

            if(data[0])
                {intakeserreqstatustypeid = data[0].intakeserreqstatustypeid;}
            if(data.length > 0)
                {isExists = data[1] > 0;}

            return Intakeservicerequestevaluation.find({
                fields: ['objectid', 'intakenumber'],
                where: {
                    and: [
                        {countyid: countyid},
                        {complaintid: complaintid}
                    ]
                },
                include: [
                {
                    relation: 'intakeservreqevaluationconfig',
                    scope: {
                        fields: ['intakeserviceid'],
                        include: {
                            relation: 'intakeservicerequest',
                            scope: {
                                fields: ['intakeserviceid', 'servicerequestnumber','intakenumber','insertedon'],
                                where: {intakeserreqstatustypeid: intakeserreqstatustypeid}
                            }
                        }
                    }
                }
                ]
            });
        })
        .then(res => {
            isrEvals = JSON.parse(JSON.stringify(res));

            const prsCrossRefs = isrEvals.filter(isrEval => isrEval.intakeservreqevaluationconfig)
            .map(isrEval => isrEval.intakeservreqevaluationconfig)
            .reduce((a,b) =>  a.concat(b), [])
            .filter(isrEvalConfig => isrEvalConfig.intakeservicerequest)
            .map(isrEvalConfig => isrEvalConfig.intakeservicerequest.servicerequestnumber)
            .map(isrnumber => {
                return new Promise((resolve, reject) => {
                    app.models.servicerequestsearch.getDetails({where: {servicerequestnumber: isrnumber}}, (err, result) => {
                        err ? reject(err) : resolve(result);
                    });
                })
            });

            return Promise.all(prsCrossRefs.reduce(function(a,b){ return a.concat(b) }, []));
        })
        .then(res => {
            const data = JSON.parse(JSON.stringify(res));

            crossRefs = data.filter(crs => crs.data && crs.data.length>0).map(crs => crs.data[0]);

            const prsIntakeCrossRefs = isrEvals
                .map(isrEval => app.models.Intakedastaging.find({
                    where: {and: [{status: 'rejected'}, {intakenumber: isrEval.intakenumber}]},
                    fields: ['intakenumber', 'datereceived', 'status', 'insertedon']
            }));

            return Promise.all(prsIntakeCrossRefs);
        })
        .then(res => {
            const data = JSON.parse(JSON.stringify(res));
            
            const intakeCrossRefs = data.reduce(function(a,b){ return a.concat(b) }, []);
            intakeCrossRefs.forEach(icr => {
                icr.complaintid = complaintid;
            });
            
            return { crossrefs: crossRefs,
                     intakecrossrefs: intakeCrossRefs, 
                     isexists: isExists };
        })
        .catch(err => util.logError(err));
    };

    Intakeservicerequestevaluation.remoteMethod('isComplaintIdExists', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			path: '/isComplaintIdExists',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    
    Intakeservicerequestevaluation.remoteMethod('getevaluationlist', {
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
            type : 'Object',
            root : true
        }
    });

    Intakeservicerequestevaluation.getevaluationlist = (request) =>{
        return app.models.Intakeservicerequestevaluation.find({
            where:{intakenumber:request.where.intakenumber},
            include: [{
                relation: "county",
                scope: {
                fields: ['countyid', 'countyname'],
                   where: {activeflag: 1}
                }
            }
            ,
            {
            relation:'offencelocationtype', 
            scope:{
                fields:['offencelocationtypeid','offencelocationtypekey','description']
            }
            },
            {
                relation: "evaluationsource",
                scope: {
                fields: ['evaluationsourceid', 'evaluationsourceagencykey','evaluationsourcekey','title','badgeno','firstname','lastname','streetno','street1','street2'],
                   where: {activeflag: 1}
                }
            },
            {
                relation: "evaluationsourceagency",
                scope: {
                fields: ['evaluationsourceagencyid', 'evaluationsourcetypekey','evaluationsourceagencykey','description'],
                   where: {activeflag: 1}
                }
            },
            {
                relation: "evaluationsourcetype",
                scope: {
                fields: ['evaluationsourcetypeid', 'evaluationsourcetypekey','description'],
                   where: {activeflag: 1}
                }
            },
            {
                relation: "intakeservicerequestevaluationconfig",
                scope: {
                fields: ['intakeservicerequestevaluationconfigid', 'intakeservicerequestevaluationid','allegationid'],
                   where: {activeflag: 1},
                   include:[{
                    relation: "allegation",
                    scope: {
                    fields: ['allegationid', 'name'],
                       where: {activeflag: 1}
                    }
                }]
            }
                
        }
    ]

        }).then(data =>{
            return data
        })
    };

    Intakeservicerequestevaluation.remoteMethod('getcomplaintlist', {
        accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
        source : 'query'
        },
        required : true
        },
        http : {
        path: '/getcomplaintlist',
        verb : 'get'
        },
        returns : {
        type : 'Object',
        root : true
        }
        });
        
        Intakeservicerequestevaluation.getcomplaintlist = function(request){

        var sql = "select intakeservicerequestevaluationid,complaintid from intakeservicerequestevaluation where intakenumber=$1 and complaintstatustypekey not in  ('CHC','PS')"

        return util.executeDBQuery(sql, [request.where.intakenumber]).then(res =>{
        return res
        })
        .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
        });
        }
        
        Intakeservicerequestevaluation.remoteMethod('getcomplaintpetitionlist', {
        accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
        source : 'query'
        },
        required : true
        },
        http : {
        path: '/getcomplaintpetitionlist',
        verb : 'get'
        },
        returns : {
        type : 'Object',
        root : true
        }
        });
        
        Intakeservicerequestevaluation.getcomplaintpetitionlist = function(request){

        var sql = "select INSE.complaintid,INSE.intakeservicerequestevaluationid,INP.intakeservicerequestpetitionid,INP.intakenumber,INP.petitionid "
        +" from intakeservicerequestevaluation INSE "
        +" left join associatedpetitionsconfig ASCO on ASCO.associatedevalfieldid=INSE.intakeservicerequestevaluationid and ASCO.activeflag = 1 "
        +" join intakeservicerequestpetition INP on INP.intakeservicerequestpetitionid=ASCO.intakeservicerequestpetitionid and INP.activeflag = 1 "
        +" where INSE.intakenumber=$1 and INSE.activeflag =1";

        return util.executeDBQuery(sql, [request.where.intakenumber]).then(res =>{
        return res
        })
        .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
        });
        }

        //sprint 4 changes for client event history
        Intakeservicerequestevaluation.remoteMethod('listClientEventHistory', {
            accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
            source : 'query'
            },
            required : true
            },
            http : {
            path: '/listClientEventHistory',
            verb : 'get'
            },
            returns : {
            type : 'Object',
            root : true
            }
            });
            
            Intakeservicerequestevaluation.listClientEventHistory = function(request){

            var sql = "select * from clienteventhistory($1,$2,$3,$4,$5,$6)"
            const skip = (request.page - 1) * request.limit;
            const limit = request.limit;
            return util.executeDBQuery(sql, [request.where.personid,request.where.foldersearch,request.where.statussearch,request.where.personstatus,skip,limit]).then(res =>{
            return res
            })
            .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
            });
            }

              //sprint 4 changes for complaint summary
        Intakeservicerequestevaluation.remoteMethod('listComplaintSummary', {
            accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
            source : 'query'
            },
            required : true
            },
            http : {
            path: '/listComplaintSummary',
            verb : 'get'
            },
            returns : {
            type : 'Object',
            root : true
            }
            });
            
            Intakeservicerequestevaluation.listComplaintSummary = function(request){

            var sql = "select * from complaintsummary($1,$2,$3,$4)"
            const skip = (request.page - 1) * request.limit;
            const limit = request.limit;
            return util.executeDBQuery(sql, [request.where.personid,skip,limit,request.where.personstatus]).then(res =>{
            return res
            })
            .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
            });
            }

            //contactsummary
                 //sprint 4 changes for complaint summary
        Intakeservicerequestevaluation.remoteMethod('listContactSummary', {
            accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
            source : 'query'
            },
            required : true
            },
            http : {
            path: '/listContactSummary',
            verb : 'get'
            },
            returns : {
            type : 'Object',
            root : true
            }
            });
            
            Intakeservicerequestevaluation.listContactSummary = function(request){

            var sql = "select * from contactsummary($1,$2,$3,$4)"
            const skip = (request.page - 1) * request.limit;
            const limit = request.limit;
            return util.executeDBQuery(sql, [request.where.personid,skip,limit,request.where.personstatus]).then(res =>{
            return res
            })
            .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
            });
            }


                 //sprint 4 changes for review summary
        Intakeservicerequestevaluation.remoteMethod('listReviewSummary', {
            accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
            source : 'query'
            },
            required : true
            },
            http : {
            path: '/listReviewSummary',
            verb : 'get'
            },
            returns : {
            type : 'Object',
            root : true
            }
            });
            
            Intakeservicerequestevaluation.listReviewSummary = function(request){

            var sql = "select * from reviewsummary($1,$2,$3,$4)"
            const skip = (request.page - 1) * request.limit;
            const limit = request.limit;
            return util.executeDBQuery(sql, [request.where.personid,skip,limit,request.where.personstatus]).then(res =>{
            return res
            })
            .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
            });
            }

                 //sprint 4 changes for complaint summary
        Intakeservicerequestevaluation.remoteMethod('listdocumentSummary', {
            accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
            source : 'query'
            },
            required : true
            },
            http : {
            path: '/listdocumentSummary',
            verb : 'get'
            },
            returns : {
            type : 'Object',
            root : true
            }
            });
            
            Intakeservicerequestevaluation.listdocumentSummary = function(request){

            var sql = "select * from documentsummary($1,$2,$3,$4)"
            const skip = (request.page - 1) * request.limit;
            const limit = request.limit;
            return util.executeDBQuery(sql, [request.where.personid,request.where.personstatus,skip,limit]).then(res =>{
            return res
            })
            .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
            });
            }

              //get complaint list from case number
    Intakeservicerequestevaluation.remoteMethod('getcomplaintlistbycasenumber', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            path: '/getcomplaintlistbycasenumber',
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });
                
    Intakeservicerequestevaluation.getcomplaintlistbycasenumber = function(request){
            var sql = "select complaintid, intakeservicerequestevaluationid from intakeservicerequestevaluation join intakeservicerequest on intakeservicerequest.intakenumber=intakeservicerequestevaluation.intakenumber where intakeservicerequest.intakeserviceid=$1"
            return util.executeDBQuery(sql, [request.where.intakeserviceid]).then(res =>{
            return res
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Intakeservicerequestevaluation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestevaluation.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestevaluation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};