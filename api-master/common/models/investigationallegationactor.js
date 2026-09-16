'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Investigationallegationactor) {

Investigationallegationactor.getinvestigationallegationdetail = data => {

	var whereClause ={activeflag : 1, investigationid : data.where.investigationid};
	if(data.where.investigationallegationid !== null)
		{whereClause.investigationallegationid = data.where.investigationallegationid;}
	
	return app.models.Investigationallegation.find({
		where : {
			and:[whereClause]		
		},
		include :{
			relation: "investigationallegationactor",
			scope: {
				where : {activeflag : 1},
				include :[{
					relation: "investigationallegationstatustype",
					scope: {
							fields: ['typedescription']
						}
				},
				{
					relation: "intakeservicerequestactor",
					scope: {
							fields: ['intakeservicerequestpersontypekey','actorid'],
							include :{
							relation: "actor",
							scope: {
								fields: ['personid'],
								include :{
									relation: "Person",
									scope: {
										fields: ['firstname','lastname']
									}
								}
							}
						}
					}
				}]					
			},		    			
		}
	})
	.then(_data => _data)
	.catch(err => util.logError(err));
};

Investigationallegationactor.remoteMethod('getinvestigationallegationdetail', {
		http: {
			path: '/getinvestigationallegationdetail',
			verb: 'post'
		},
		accepts : [{
			arg : 'data',
			type : 'object',
			http : {source : 'body'}
		}],   
		returns: {
			type : 'object',
			root : true
		}
	});

	Investigationallegationactor.remoteMethod('getAllegations', {
        accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        },
        {
            arg : 'filter',
            type : 'object',
            required : false,
            http : { source: 'query' }
        }],
        http: {"verb": "get", "path": "/getAllegations/:id"},
        returns : {
        type : 'Object',
        root : true
        }
    });

    Investigationallegationactor.getAllegations = (id,  data) => {
        return Investigationallegationactor.findById(id, {
            
			where: {activeflag: 1},
			fields: ['investigationallegationactorid', 'intakeservicerequestactorid','investigationallegationid', 'statementofevidence', 'investigationallegationstatustypekey', 'addedindicators'],
			include: [
				{
				relation: 'investigationallegation',
				scope: {
					where: {activeflag: 1},
					fields: ['investigationallegationid', 'allegationid', 'indicators', 'financial'],
					include: {
						relation: 'allegation',
						scope: {
							fields: ['allegationid'],
							where: {activeflag: true},
							include: {
								relation: 'allegationstatestatutes',
								scope: {
									fields: ['statestatuteid'],
									where: {activeflag: true},
									include: {
										relation: 'statestatutes',
										scope: {
											fields: ['statestatuteskey','description', 'statestatutetext']
										}
									}
								}
							}
						}
					}
				}
			},
			{
				relation: 'intakeservicerequestactor',
				scope: {
					fields: ['intakeservicerequestactorid', 'intakeserviceid', 'actorid'],
					where: {activeflag: true},
					include: {
						relation: 'actor',
						scope: {
							fields: ['actorid', 'personid', 'actortype'],
							where: {and : [
								{activeflag: true}, 
							]
							},
							include: {
								relation: 'Person',
								scope: {
									fields: ['firstname', 'lastname'],
									where: {activeflag: 1}
								}
							}
						}
					}
				}
			},
			{
				relation: "investigationallegationstatustype",
				scope: {
					fields: ["typedescription"],
				}
			}
			]
		})
		.then(_data => _data)
		.catch(err => err);
	};
	
	Investigationallegationactor.remoteMethod('updateAllegationActor', 
    			    {
    			      http: {
    			      		path: '/updateAllegationActor/:id',
    			      		verb: 'post'
    			      },
    			     accepts : [ 
						{
							arg: 'id',
							type: 'string',
							required: true,
							http: {source: 'path'}
						},
						 {arg : 'data',type : 'object',
							 http : {source : 'body'}
						 }
						],   
    			      returns: {
    			    	  type : 'object',
    						root : true
    			      }
    			    
    		});
    
 
    Investigationallegationactor.updateAllegationActor = (id, req) => {
		var request = req.where;
        const investigationAllegationId = request.investigationallegationid;
		
		const prs = [];
		prs.push(app.models.Investigationallegationactor
			.updateAll({investigationallegationactorid: id}, request)
		);

		if(investigationAllegationId) {
			prs.push(app.models.Investigationallegation
				.updateAll({investigationallegationid: investigationAllegationId}, request.investigationallegation)
			);
		}
        return Promise.all(prs)
        .then(data => data)
        .catch(err => util.logError(err));
    };

    Investigationallegationactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationallegationactor.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationallegationactor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
