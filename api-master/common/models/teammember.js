'use strict';
const LOGGER = require("log4js").getLogger("teammember");

var server = require('../../server/server');
const util = require('../utils/utils');


module.exports = Teammember => {

Teammember.observe('access', function logQuery(ctx, next) {
        LOGGER.debug('Accessing %s matching %s', ctx.Model.modelName, ctx.query.where);
        next();
      });

	function validateinput(str){
		if(str === 'undefined')
			{
	           return null; 		
			}else {
				return str;	
			}
		
	}
	
    Teammember.remoteMethod('details', {
        accepts : [{
                arg: 'id',
                type: 'string',
                required: true,
                http: {source: 'path'}
            },
            {
                arg: 'filter',
                type: 'Object',
                required: false,
                http: {source: 'query'}
            }
        ],
        http: {"verb": "get", "path": "/details/:id"},
		returns : {
			type : 'Object',
			root : true
		}
    });

    Teammember.details = (id, arg) => {
        return Teammember.findById(id, {
            fields: ['teammemberid'],
            where: {activeflag: true},
            include: [{
                relation: "teammemberassignment",
                scope: {
                    fields: ["securityusersid"],
                    where: {activeflag: true},
                    include: {
                        relation: "userprofile",
                        scope: {
                            fields: ['userworkstatustypekey', 'firstname', 'lastname', 'fullname', 'email', 'securityusersid', 'isavailable'],
                            where: {activeflag: true},
                            include: [
                                {
                                    relation: "userworkstatustype",
                                    scope: {
                                        fields: ["typedescription"],
                                        where: {activeflag: true}
                                    }
                                },
                                {
                                    relation: "userprofileaddress",
                                    scope: {
                                        fields: ['securityusersid', 'address', 'zipcode', 'pobox', 'city', 'county', 'state', 'country'],
                                        where: {activeflag: true}
                                    }
                                },
                                {
                                    relation: "userprofilephonenumber",
                                    scope: {
                                        fields: ['securityusersid', 'phoneextension', 'phonenumber', 'userprofiletypekey'],
                                        where: {activeflag: true}
                                    }
                                }
                            ]
                        }
                    }
                }
            },
            {
                relation: "areateammemberservicerequest",
                scope: {
                    fields: ["teammemberid", "intakeserviceid", "routingstatustypekey"],
                    where: {activeflag: true},
                    include: {
                        relation: "intakeservicerequest",
                        scope: {
                            fields: ["intakeserviceid", "intakeserreqstatustypeid", "servicerequestnumber", "effectivedate", "intakeservreqtypeid", "intakeservicerequestclassid", "targetcompletedate"],
                            where: {activeflag: true},
                            include: [{
                                relation: "intakeservicerequesttype",
                                scope: {
                                    fields: ["intakeservreqtypeid", "intakeservreqtypekey"],
                                    where: {activeflag: true}
                                }
                            },
                            {
                                relation: "servicerequestsubtype",
                                scope: {
                                    fields: ["servicerequestsubtypeid", "classkey"],
                                    where: {activeflag: true}
                                }
                            },
                            {
                                relation: "intakeserreqstatustype",
                                scope: {
                                    fields: ["intakeserreqstatustypeid", "intakeserreqstatustypekey"],
                                    where: {activeflag: true}
                                }
                            },
                            {
                                relation: "intakeservicerequestactor",
                                scope: {
                                    fields: ["intakeservicerequestactorid", "intakeserviceid", "actorid"],
                                    where: {activeflag: true},
                                    include: {
                                        relation: "actor",
                                        scope: {
                                            fields: ["actorid", "personid", "actortype"],
                                            where: {and : [{activeflag: true}, {actortype: "RA"}]},
                                            include: {
                                                relation: "Person",
                                                scope: {
                                                    fields: ["personid", "firstname", "lastname"],
                                                    where: {activeflag: 1}
                                                }
                                            }
                                        }
                                    }
                                }
                            },
                            {
                                relation: "intakeservicerequestgroupdetails",
                                scope: {
                                    fields: ["groupid", "intakeserviceid"],
                                    where: {activeflag: true},
                                    include: {
                                        relation: "intakeservicerequestgroup",
                                        scope: {
                                            fields: ["groupid", "groupnumber"],
                                            where: {actortype: "RA"}
                                        }
                                    }
                                }
                            }
                        ]
                            
                        }
                    }
                }
            }
        ]
        })
        .then(members => members)
        .catch(err => LOGGER.error(err));
    };

    Teammember.getgroupinglist = function(request){

    var sql = 'select * from getgroupinglist($1,$2,$3,$4,$5,$6)';

	   LOGGER.debug("SQL : "+sql);
	   return util.executeDBQuery(sql, [request.page,request.limit,request.order,request.where.firstname,request.where.lastname,request.where.positioncode])
	   .then(data => {
	   		return data[0].getgroupinglist[0];
	   })
	   .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

};
    Teammember.remoteMethod('getgroupinglist', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get',
			path : "/getgroupinglist/list"
		},
		returns : {
			type : 'string',
			root : true
		}
	});

    Teammember.getteammemberdetails = function(data){

 		var sql = 'select * from getteammemberdetails($1,$2,$3,$4,$5,$6)';

 		/*
 		    position_code character varying,role_type character varying, first_name character varying,last_name character varying,page integer,size integer
 		 */
 		LOGGER.debug("sql : "+sql);

 		return util.executeDBQuery(sql, [validateinput(data.where.positioncode),validateinput(data.where.roletypekey),validateinput(data.where.firstname),validateinput(data.where.lastname),validateinput(data.where.servicerequesttypeconfigid),data.where.type])
 		.then(_data => {
 			return _data[0].getteammemberdetails[0];
 		})
 		.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

     };
    
     Teammember.remoteMethod('getteammemberdetails', {
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
 	
     Teammember.getteammemberlist = function(data){

  		/*  -- Parameter
		    _filtertype character varying,
            _uuid character varying,
            _role_type character varying,
            _first_name character varying,
            _last_name character varying,
            _position_code character varying
		 */

   		var sql = 'select * from getmanageaccesslist($1,$2,$3,$4,$5,$6)';

   		LOGGER.debug("sql : "+sql);

   		return util.executeDBQuery(sql, [data.filtertype,data.uuid,data.roletype,data.firstname,data.lastname,data.positioncode])
   		.then(_data => {
   			return _data[0].getmanageaccesslist[0];
   		})
   		.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

       };

     
     Teammember.remoteMethod('getteammemberlist', {
	      http: {
	      		path: '/getteammemberlist',
	      		verb: 'post'
	      },
	     accepts : [ {arg : 'data',type : 'object',
	     		http : {source : 'body'}} ],   
	      returns: {
	    	  type : 'object',
				root : true
     }
   });

   Teammember.remoteMethod('reassign', {
        http: {
                path: '/reassign',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],   
        returns: {
            type : 'object',
            root : true
        }
    });

    Teammember.reassign = (arg) => {
        const userid = server.currentUser.id;

        const sql = 'select * from routeda_manual_reassign($1, $2, $3,  $4)';
        const params = [arg.intakeserviceid, arg.old_teammemberid, arg.new_teammemberid, userid];

        return util.executeDBQuery(sql, params)
        .then(data => {
            var resp = data.map(x => x[Object.keys(x)[0]]);
            if(data.length > 0){
                return resp[0];}
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
     
     Teammember.remoteMethod('list', {
         accepts : [{
                 arg: 'id',
                 type: 'string',
                 required: true,
                 http: {source: 'path'}
             }
             
    ],
         http: {"verb": "get", "path": "/list/:id"},
 		returns : {
 			type : 'Object',
 			root : true
 		}
     }); 
     

     Teammember.list = (id) => (Teammember.findById(id, {
	         
			
     	 where: {activeflag: true},
     	 fields: ['teammemberid','teamid','positioncode','loadnumber','effectivedate'],
     	 include:[{
     		 relation: 'teammemberassignment',
              where: {activeflag: true},
              scope: {
             	 fields: ['teammemberassignmentid','teammemberid','securityusersid','expirationdate','effectivedate','expirationdate','voidreasonid','coadate','rtfdate'],
             	 include:
             		 {
                 		 relation: 'securityusers',
                          scope: {
                              fields: ['securityusersid'],
                              where: {activeflag: true},
                         	 include:{ relation:'userprofile',
                         		 scope: {	 
                         		 fields: ['securityuserid','firstname','lastname','displayname','fullname','orgname','orgnumber'],	
                         	 }
                          }
                 	    }
                 	 }
             	  }
     	 },
     	
     	{
             relation: 'team',
             where: {activeflag: true},
             scope: {
            	 fields: [ 'teamname', 'teamnumber','teamid'],
            	 
             }
         }]
     	 
     	
         
          
 })
    );
    
    // Reassign Search

    Teammember.getuserassignlist = function(data){

        var firstname,lastname,positioncode;

        if(data.where !== undefined){
            firstname = data.where.firstname;
            lastname = data.where.lastname;
            positioncode = data.where.positioncode;
        }

        const sql = 'select * from getuserassignlist($1, $2, $3, $4, $5)';
        const params = [data.page, data.limit, firstname, lastname, positioncode];

        LOGGER.debug("SQL : "+sql);
        LOGGER.debug("Params : "+ JSON.stringify(params));
        return util.executeDBQuery(sql, params)
        .then(_data => {
            LOGGER.debug(_data);
            return _data[0].getuserassignlist[0];
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

 };
     Teammember.remoteMethod('getuserassignlist', {
         accepts : {
             arg : 'filter',
             type : 'Object',
             http : {
                 source : 'query'
             },
             required : true
         },
         http : {
             verb : 'get',
             path : "/getuserassignlist/list"
         },
         returns : {
             type : 'string',
             root : true
         }
     });
     
     
     
//  Reassignment History list
    Teammember.remoteMethod('reassignmenthistory', {
        accepts : [{
                arg: 'id',
                type: 'string',
                required: true,
                http: {source: 'path'}
            }
            /*,
            {
                arg: 'filter',
                type: 'Object',
                required: true,
                http: {source: 'query'}
            },*/
            
   ],
        http: {"verb": "get", "path": "/reassignmenthistory/:id"},
        returns : {
            type : 'Object',
            root : true
        }
    }); 

    Teammember.reassignmenthistory = (id1,arg) => (Teammember.findById(id1, {
        where: {activeflag: true},
        fields: ['teammemberid','teamid','positioncode','loadnumber','effectivedate'],
        include:[{
            relation: 'teammemberassignment',
            where: {activeflag: true},
            scope: {
                fields: ['teammemberassignmentid','teammemberid','securityusersid','expirationdate','effectivedate','expirationdate','voidreasonid','coadate','rtfdate'],
                include:
                    {
                        relation: 'securityusers',
                        scope: {
                            fields: ['securityusersid'],
                            where: {activeflag: true},
                            include:{ relation:'userprofile',
                                scope: {	 
                                fields: ['securityuserid','firstname','lastname','displayname','fullname','orgname','orgnumber'],	
                            }
                        }
                       }
                    }
                 }
        },
       
       {
           relation: 'team',
           where: {activeflag: true},
           scope: {
               fields: [ 'teamname', 'teamnumber','teamid'],
               
           }
       }]
        
}));
     
//  Zip Code list Start
Teammember.remoteMethod('countylist', {
    accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        },
        {
            arg: 'filter',
            type: 'Object',
            required: false,
            http: {source: 'query'}
        }
    ],
    http: {"verb": "get", "path": "/countylist/:id"},
    returns : {
        type : 'Object',
        root : true
    }
});

Teammember.countylist = (id, arg) => {

    var prs = [];
    prs.push(Teammember.findById(id, {
        fields: ['teammemberid'],
        where: {activeflag: true},
        include: [{
            relation: "countyareateammember",
            scope: {
                fields: ["countyid","teammemberid"],
                where: {activeflag: true},
                include: {
                    relation: "county",
                    scope: {
                        fields: ['countyid','countyname', 'regionid', 'statecountycode', 'fipscode', 'longitude', 'latitude', 'state','apsregion','ltcregion','zipcode','city'],
                        where: {activeflag: true},
                    }
                }
            }
        }
        
    ]
    }));

    if (arg.page !== 'undefined' && arg.page === 1) {
        prs.push(
            server.models.Countyareateammember.count({
                and : [{activeflag: true}, {teammemberid: id}]
            })
        );
    }

    return Promise.all(prs)
        .then(data => {
            var resp = {};
            
            resp.data = data[0];

            if(data.length>1){
                resp.count = data[1];
            }

            return resp;
        })
        .catch(err => err);
}

Teammember.remoteMethod('updateworkstatus', {
        http: {
                path: '/update',
                verb: 'patch'
        },
        accepts : [
            {
                arg : 'data',
                type : 'object',
                http : {source : 'body'}
            }],
        returns: {
            type : 'object',
            root : true
        }
    });

    Teammember.updateworkstatus = (arg) => {
        const teammemberid = arg.teammemberid;

        return server.models.Teammemberassignment.find({where: {and: [{teammemberid: teammemberid}, {activeflag: 1}]}, fields:["securityusersid"]})
        .then(tm => {
            LOGGER.debug(JSON.stringify(tm));
            const securityusersid = tm[0].securityusersid;
            LOGGER.debug(securityusersid);
            return server.models.Userprofile.updateAll({securityusersid: securityusersid}, {userworkstatustypekey: arg.userworkstatustypekey, isavailable: arg.isavailable})
            .then(data=>{
                LOGGER.debug(JSON.stringify("data:"+data));
                return data;
            })
            .catch(err=>err);
        })
        .then(data => data)
        .catch(err => err);
    };

    Teammember.updateuserposition = (request,reqctx) => {

let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        return Teammember.updateAll({
            teammemberid: request.teammemberid,
        },
            {
                teamid: request.teamid,
                updatedby: (request && request.securityuserid?request.securityuserid: suserid)
            }).then(data => {
                    return 'Updated Successfully';
                }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            };

      Teammember.remoteMethod('updateuserposition', {
                http: {
                        path: '/updateuserposition',
                        verb: 'post'
                },
                accepts : [ {arg : 'data',type : 'object',
                    http : {source : 'body'}}
                    ,{
                        arg: 'reqctx',
                        type: 'object',
                        http: {source: 'context'}
                      } ],
                returns: {
                    type : 'string',
                    root : true
                }
            });


            Teammember.add = function (request) {

                return Teammember.create(request).
                    then(data => { 
                        request.teammemberid = data.teammemberid;
                        return server.models.Role.findOne({
                           where:{roletypekey:request.roletypekey}
                        }).then(response => {
                            request.roleid = response.id;
                            return server.models.Teammemberassignment.create(request)
                            .then( result => {
                                return server.models.Team.findOne({
                                    where:{teamid:request.teamid}
                                 })}).then(resp => {
                                    return server.models.Userprofile.updateAll(
                                            {securityusersid: request.securityusersid},
                                            {teamtypekey:resp.teamtypekey})   
                                }).then( result => {
                                request.principaltype = 'USER';
                                request.principalid = request.userid;
                                return server.models.Rolemapping.create(request)
                            })
                        })
                        .then(res => res)
                        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
                    }) .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })

            }
        
            Teammember.remoteMethod('add', {
                accepts: {
                    arg: 'data',
                    type: 'object',
                    http: {
                        source: 'body'
                    },
                    required: true
                },
                http: { "verb": "post", "path": "/add" },
                returns: {
                    type: 'object',
                    root: true
                }
            });   
        

    Teammember.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Teammember.observe('access', (ctx, next) => util.access(ctx, next));
    Teammember.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
