'use strict';
const LOGGER = require("log4js").getLogger("team");

var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = Team => {

    //Function to convert list to tree list based on parent child relationship
    const makeTree = (team, origTeam) => {
        team.children = origTeam.filter(x => x.parentteamid === team.id);
        team.children.forEach(x => makeTree(x, origTeam));
    };
    
    //*** Remote method calls

    //Custom List Tree method

    Team.remoteMethod('listtree', {
        accepts : {
            arg: 'arg',
            type: 'Object',
            http: {source: 'query'}
        },
        description: "Tree View List",
        notes: "Tree View List - Will give the Teams in tree view with parent child relationship",
        http: {"verb": "get", "path": "/listtree"},
		returns : {
			type : 'Object',
			root : true
		}
    });

    Team.listtree = (arg) => {
        return Team.find({
            fields: ['id', 'name', 'teamnumber', 'parentteamid'],
            nolimit: true,
            order: 'name asc',
            where:{
                activeflag: true
            }
        })
        .then(teams => {
            let result = JSON.parse(JSON.stringify(teams));
            result
                .filter(x => x.parentteamid === null)
                .forEach(x => makeTree(x, result));
            result = result.filter(x => x.parentteamid === null);
            return result;
        })
        .catch(err => LOGGER.error(err));
    };

    // Team.afterRemote('listtree', (ctx, project, next) => {
    //     let result = JSON.parse(JSON.stringify(ctx.result));
        
    //     result
    //         .filter(x => x.parentteamid === null)
    //         .forEach(x => makeTree(x, result));
    //     result = result.filter(x => x.parentteamid === null);
    //     ctx.result = result;
    //     next();
    // });

    
    //Custom Details method with team members details

    Team.remoteMethod('details', {
        accepts : [{
                arg: 'id',
                type: 'string',
                required: true,
                http: {source: 'path'}
            },
            {
                arg: 'filter',
                type: 'Object',
                required: true,
                http: {source: 'query'}
            },
        ],
        description: "Team details",
        notes: "Team details - Team details with Team type",
        http: {"verb": "get", "path": "/details/:id"},
		returns : {
			type : 'string',
			root : true
		}
    });
    
    //Custom List method related functions

    Team.details = (id, arg) => {
        var prs = [];

        prs.push(Team.findById(id, {
            fields: ['id', 'teamtypekey', 'teamnumber', 'name', 'region', 'officetimingfrom', 'officetimingto','effectivedate','expirationdate','parentteamid','countyid'],
            where: {activeflag: true},
            include:[ {
                relation: 'teamtype',
                scope: {
                    fields: "description"
                }
            },{
                relation: 'county',
                scope:{
                    fields: "countyname"
                }
            }]
        }));
        
        var email = arg.email?arg.email:'';

        const sql = 'select * from getteammembers($1, $2, $3, $4)';
        const params = [id, arg.limit, (arg.page-1) * arg.limit,email];

        prs.push(util.executeDBQuery(sql, params));

        return Promise.all(prs)
        .then(data => {
            var resp = {};
            var teamData =  {
                team: data[0],
                teammembers: data[1]
            };
            resp.data = teamData;

            if (arg.page !== 'undefined' && arg.page === 1) {
                resp.count = data[1] && data[1][0] ? data[1][0].count: undefined;
            }
         

            return resp;
        })
        .catch(err => err);
    };

    var totalCount;
	Team.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
		request.order = 'name asc';
		return Team.find(request);

	};
	
	
	//if count is zero don't execute the listing else
	 // return the list also *
	
	Team.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			
			Team.count(function(err, count) {

			if (err) {
				throw err;
			}
			totalCount = count;

		});
		
		}

		next();
	});
	
	Team.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});
    
    Team.remoteMethod('list', {
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
  
  //Teams & Positions Setup New Parent Team list
Team.remoteMethod ('parentteamlist',{
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
        type : 'string',
        root : true
    }
});

Team.parentteamlist = function(request) {
   
    return Team.find({
        fields: ['id','teamtypekey', 'name'],
        where: {and:[{activeflag: true},{teamtypekey: request.where.teamtypekey}]},
        nolimit: request.nolimit,
        include: {
            relation: 'teamtype',
            scope: {
            fields: ['teamtypekey','description']
            }
        },
    })
};



Team.teamlist =(request)=>{
     return Team.find({
    fields:['name','id'],
    where:{
        activeflag:true,
        teamtypekey:request.where.teamtypekey,
         },
    nolimit:true
     })
     .catch(err => err)
}

Team.remoteMethod('teamlist', {
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
        const findElement = element =>{
        const prs=[];
        var steammemberid;
        var teammemberid = element.teammemberid;

        return app.models.Teammemberassignment.find({
                where:{
                        teammemberid:teammemberid
                }
            })
        .then(res => {
            
        if(res.length > 0) {
                var tmid = JSON.parse(JSON.stringify(res));
            if(Array.isArray(tmid)){
                prs.push(tmid.map(ele =>{
                        steammemberid  = ele.teammemberid;
                        return app.models.Teammember.findOne({
                            fields:['teammemberid','positioncode','roletypekey'],
                                where:{
                                teammemberid:steammemberid   
                                }
                        })
                    })
                );
                var flatPrs = prs.reduce((a,b) => a.concat(b), []);
                return Promise.all(flatPrs);
            }   
        }
        }).then(res =>{
            var returndata ={};
            if(res !== undefined){
                returndata = res[0];
            }            
            return returndata;
          })
        };

// for edit position dropdown  based on userid and teamid 
Team.positionidlist =(request) =>{
    var id = request.where.id; // userid 
    var tsdataobj =[]; 
    return app.models.User.findById(id, {
        fields: [],
        include: {
          relation: 'userprofile',
          scope: {
            include: [{
              relation:'teammemberassignment',
              scope:{
                fields:['teammemberid'],
                include:{
                  relation:'teammember',
                   scope:{
                      fields:['teammemberid','positioncode','roletypekey']
                   }
                  }
              }  
            }
          ]
          }
        }
      }).then(data =>{
        var result = JSON.parse(JSON.stringify(data));
        var dataobj = result.userprofile.teammemberassignment.teammember;
           tsdataobj.push(dataobj);
        return app.models.Teammember.find({
            fields:['teammemberid'],
        where:{
            teamid:request.where.teamid
        }
      })
    }).then(data =>{
        let prs = [];
        const teammember = JSON.parse(JSON.stringify(data));
        if(Array.isArray(teammember)){
            prs = teammember.map(element=> findElement(element));
            var flatprs = prs.reduce((a,b)=> a.concat(b),[]);
            return Promise.all(flatprs);
        }
    }).then(resp =>{
        var loadobj = JSON.parse(JSON.stringify(resp));
        var datasourcesobj = loadobj.reduce((a,b) => a.concat(b),[]);
        var respond = tsdataobj.concat(datasourcesobj);
        respond = respond.filter((thing, index, self) => self.findIndex(t => t.teammemberid === thing.teammemberid) === index)
        return respond.filter(value => Object.keys(value).length !== 0);
    })                 
}

Team.remoteMethod('positionidlist', {
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

Team.remoteMethod('getteam', {
    http: {
        path: '/getteam',
        verb: 'get'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'query'}
    },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      } ],  
    returns: {
        type : 'object',
        root : true
    } 
});

Team.getteam =(request,reqctx)=> {    
    
let suserid = undefined;
if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
  suserid = reqctx.req.headers.securityusersid
}
    var securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
    var sql = 'select * from getteam($1)';
    return util.executeDBQuery(sql, [securityuserid])
    .then(datas => datas)
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

Team.remoteMethod('getteamlist', {
    http: {
        path: '/getteamlist',
        verb: 'get'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'query'}
    },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      } ],  
    returns: {
        type : 'object',
        root : true
    } 
});

Team.getteamlist =(request,reqctx)=> {
    
let suserid = undefined;
if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
  suserid = reqctx.req.headers.securityusersid
}
    var susersid = (request && request.securityuserid?request.securityuserid: suserid);
    var sql = 'select * from getteamlist($1,$2,$3)';
    var teamid   = request.where.teamid?request.where.teamid:null;
    return util.executeDBQuery(sql, [susersid, request.where.teamtypekey, teamid])
    .then(datas => datas)
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};


Team.getteamusers = function (data,reqctx) {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    var userid = (data && data.securityuserid?data.securityuserid: suserid);
    var teamid = data.where.teamid;
    var inactivelist = data.where.inactivelist ? data.where.inactivelist : false;
    var inactiveuseractivecaselist = data.where.inactiveuseractivecaselist ? data.where.inactiveuseractivecaselist : false;
    var filtertypekey = data.where.filtertypekey?data.where.filtertypekey:'';
    var sql = 'SELECT * FROM getteamusers($1,$2,$3,$4,$5)';
    var params = [teamid,userid, filtertypekey,inactivelist,inactiveuseractivecaselist];
    return util.executeDBQuery(sql, params)
      .then(_data => {
        return _data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Team.remoteMethod('getteamusers', {
    http: {
        path: '/getteamusers',
        verb: 'get'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'query'}
    },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      } ],  
    returns: {
        type : 'object',
        root : true
    } 
    });

    Team.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Team.observe('access', (ctx, next) => util.access(ctx, next));
    Team.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
