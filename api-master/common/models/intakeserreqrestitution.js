'use strict';
const LOGGER = require("log4js").getLogger("intakeserreqrestitution");
const util = require('../utils/utils');
var app = require('../../server/server');

const withCount = rows => {
    let totalcount = 0;
    if (rows !== null && rows.length > 0) { 
        totalcount = rows[0].totalcount; 
    }
    const result = {
        'data': rows,
        'count': totalcount
    };
    LOGGER.debug(result);
    return result;
};

const logAndReturn = err => {
    util.logError(err);
    LOGGER.error(err);
    return err;
};

const stripCount = (rows, showCount) => {
    let totalcount = 0;
    if (rows.length > 0) { 
        totalcount = rows[0].totalcount; 
    }
    const cleaned = JSON.parse(JSON.stringify(rows));
    cleaned.forEach(x => {
        delete x.totalcount;
    });
    if (showCount) {
        return {
            'count': totalcount,
            'data': cleaned
        };
    }
    return {
        'data': cleaned
    };
};

module.exports = function(Intakeserreqrestitution) {

    
    //sprint 4 changes for complaint summary
    Intakeserreqrestitution.remoteMethod('listrestitutionwithsearch', {
    
        http: {
                path: '/listrestitutionwithsearch',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},
            {arg: 'reqctx', type: 'object',
            http: {source: 'context'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });
               
                    
    Intakeserreqrestitution.listrestitutionwithsearch = async function(request,reqctx){
        var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
          }  
        var teamcounty;
        var requestuserinfo = {'token': '', 'email': _email};
        await util.getuserinfo(requestuserinfo).then (data => {
            teamcounty = data.countyid;
        });
        if(request.intakeserviceid)
        {
            teamcounty=null;
        }
        var sql = "select * from getrestitutionwithsearch($1,$2,$3,$4,$5)"
        const skip = (request.page - 1) * request.limit;
        const limit = request.limit;
        return util.executeDBQuery(sql, [teamcounty,request.where.intakeserviceid,request.where.searchvals,skip,limit])
        .then(res =>{
            return res
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Intakeserreqrestitution.getchangeformlist = (id, request) => {
        const limit = request.limit;
        const skip = (request.page - 1) * request.limit;

        var sql = "select * from rstnchangeformlist($1,$2, $3)";
        return util.executeDBQuery(sql,[id,skip,limit])
            .then(withCount)
            .catch(logAndReturn)
    };

    Intakeserreqrestitution.remoteMethod('getchangeformlist', {
        http: {
            path: '/getchangeformlist/:id',
            verb: 'get'
        },
        accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        },
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });
        
   Intakeserreqrestitution.remoteMethod('getplacementrestitution', {
    http: {
        path: '/getplacementrestitution',
        verb: 'get'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'query'}
    } ],  
    returns: {
        type : 'object',
        root : true
    } 
});

    Intakeserreqrestitution.getplacementrestitution = function (request) {
        LOGGER.debug(request.where.personid + "personid");
        const limit = request.limit;
        const skip = request.page;
        var sql = "select * from getplacementrestitution($1,$2,$3)";
        return util.executeDBQuery(sql,[request.where.personid,skip,limit])
            .then(withCount)
            .catch(logAndReturn)
    };
        
                
    //sprint 4 changes for complaint summary
                
    Intakeserreqrestitution.remoteMethod('transferrestitution', {
		accepts: [
			{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
			{
				arg: 'data',
				type: 'object',
				http: { source: 'body' }
			},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
		http: { "verb": "patch", "path": "/transferrestitution/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});
                
    Intakeserreqrestitution.transferrestitution = function(id,request,reqctx){

    return Intakeserreqrestitution.updateAll({intakeserreqrestitutionid: id}, request.county)
    .then(_data => {

    //return new Promise((resolve, reject) => {
        var sql = "select mu.securityusersid from team t join teammember tm on tm.teamid=t.teamid and tm.activeflag=1 join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1 join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1 "
            +" join rolemapping rm on rm.principalid::int=mu.id and rm.activeflag=1 join role r on r.id = rm.roleid :: int "
            +" where t.countyid=$1 and r.roletypekey='JSRTC'";
        return util.executeDBQuery(sql, [request.county.countyid]);
    }).then(data => {
        if(data.length>0)
        {


        var nofiticationJson ={};
        nofiticationJson.securityusersid = data[0].securityusersid;
        nofiticationJson.usernotificationtypekey="System";
        nofiticationJson.objectid=id;
        nofiticationJson.subject='Restitution "' + request.restitutionid +'" has been assigned by  "'+app.currentUser.userprofile.fullname+'"';
        nofiticationJson.priorityleveltypekey ="Normal";
        nofiticationJson.body='Restitution "' + request.restitutionid +'" has been assigned by  "'+app.currentUser.userprofile.fullname+'"';

        app.models.Usernotification.Add(nofiticationJson,reqctx);
        }
    // else{
    //     resolve(data);
    // }
        return data;
    })
    .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
    });
  }

  
    
    Intakeserreqrestitution.remoteMethod('listrestitutioncaseworker', {
        http: {
        path: '/listrestitutioncaseworker',
            verb: 'get'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'query'}
        } ],  
    returns: {
            type : 'object',
            root : true
        } 
    });

    Intakeserreqrestitution.listrestitutioncaseworker = function(request){

    var sql = "select * from getrestitutioncaseworker($1,$2,$3,$4)"
    const skip = (request.page - 1) * request.limit;
    const limit = request.limit;
    return util.executeDBQuery(sql, [request.where.intakeserviceid,request.where.intakeserreqrestitutionid,skip,limit])
    .then(res =>{
    return res
    })
    .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
    });
    }
    
    Intakeserreqrestitution.addupdaterestitution = (data, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const userid = (data && data.securityuserid?data.securityuserid: _securityusersid);
        var sql = 'SELECT * FROM addupdaterestitution($1, $2)';
        return util.executeDBQuery(sql, [JSON.stringify(data), userid])
        .then(_data => {
            LOGGER.info(_data);
            return _data[0];
        })
        .catch(logAndReturn)
    };

    Intakeserreqrestitution.remoteMethod('addupdaterestitution', {
        http: {
                path: '/addupdaterestitution',
                verb: 'post'
        },
        accepts : [{arg : 'data',type : 'object',
            http : {source : 'body'}
        } , {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        returns: {
            type : 'object',
            root : true
        }
    
    });

    Intakeserreqrestitution.closerestitution = (data, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const userid = (data && data.securityuserid?data.securityuserid: _securityusersid);
        
        var sql = 'SELECT * FROM closerestitution($1, $2)';
        return util.executeDBQuery(sql, [JSON.stringify(data), userid])
       .then(_data => _data[0])
       .catch(err => util.logError(err));
    };

    Intakeserreqrestitution.remoteMethod('closerestitution', {
        http: {
                path: '/closerestitution',
                verb: 'post'
        },
        accepts : [{arg : 'data',type : 'object',
            http : {source : 'body'}
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
        returns: {
            type : 'object',
            root : true
        }
    
    });

    Intakeserreqrestitution.restichangeformrequest = (data, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const userid = (data && data.securityuserid?data.securityuserid: _securityusersid);
        
        var sql = 'SELECT * FROM restichangeformrequest($1, $2)';
        return util.executeDBQuery(sql, [JSON.stringify(data), userid])
       .then(_data => _data[0])
       .catch(err => util.logError(err));
    };

    Intakeserreqrestitution.remoteMethod('restichangeformrequest', {
        http: {
                path: '/restichangeformrequest',
                verb: 'post'
        },
        accepts : [{arg : 'data',type : 'object',
            http : {source : 'body'}
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Intakeserreqrestitution.restichangeformapprovereject = (data, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const userid = (data && data.securityuserid?data.securityuserid: _securityusersid);
        
        var sql = 'SELECT * FROM restichangeformapprovereject($1, $2)';
        return util.executeDBQuery(sql, [JSON.stringify(data), userid])
       .then(_data => _data[0])
       .catch(err => util.logError(err));
    };

    Intakeserreqrestitution.remoteMethod('restichangeformapprovereject', {
        http: {
                path: '/restichangeformapprovereject',
                verb: 'post'
        },
        accepts : [{arg : 'data',type : 'object',
            http : {source : 'body'}
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Intakeserreqrestitution.deleterestitution = id => {
        return Intakeserreqrestitution.updateAll({intakeserreqrestitutionid: id}, {activeflag: 0})
        .then(data => data)
        .catch(err => util.logError(err));
    };

    Intakeserreqrestitution.remoteMethod('deleterestitution', {
        http: {
                path: '/deleterestitution/:id',
                verb: 'delete'
        },
        accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        }],
        returns: {
            type : 'object',
            root : true
        }
    
    });

    Intakeserreqrestitution.restitutionpaymentflatfilelist = function(data) {
        var showCount = false;
        if(data.page === 1){
            showCount = true;
        }/* else{showCount = false}; */     //SonarQube fix - commented as showCount is already set to false above
        if (data.where.searchfile==null || data.where.searchfile==undefined) {data.where.searchfile='';}
        if (data.where.startdate==null || data.where.startdate==undefined) {data.where.startdate='';}
        if (data.where.enddate==null || data.where.enddate==undefined) {data.where.enddate='';}

        var sql1 = 'select * from restitutionpaymentflatfilelist($1,$2,$3,$4,$5)';
        return util.executeDBQuery(sql1,[data.where.searchfile,data.where.startdate,
            data.where.enddate,data.page,data.limit])
            .then(_data => stripCount(_data, showCount))
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Intakeserreqrestitution.remoteMethod('restitutionpaymentflatfilelist', {
        accepts : {
                arg : 'data',
                type : 'object',
                required : true,
                http : { source: 'query' }
            },
        http: {
            'verb': 'get', 
            'path': '/restitutionpaymentflatfilelist'
            },
        returns : {
            type : 'object',
            root : true
            }
    });
   

    Intakeserreqrestitution.remoteMethod('listrestitutionperson', {
        http: {
                path: '/listrestitutionperson',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });
    
    Intakeserreqrestitution.listrestitutionperson = function(request)
    {
        var inputjson = request.where;
        var pagesize = request.limit;
        var pagenumber = request.page;

        inputjson.pagesize = pagesize;
        inputjson.pagenumber = pagenumber;


        var sql = "select * from getlistrestitutionperson($1)";

        return util.executeDBQuery(sql,[inputjson])
            .then(withCount)
            .catch(err => util.logError(err));
        };

        Intakeserreqrestitution.remoteMethod('getrestitutionfilecontent', {
            http: {
                path: '/getrestitutionfilecontent',
                verb: 'get'
            },
            accepts : [ 
            {
                arg : 'filter',
                type : 'object',
                http : {source : 'query'}
            } ],  
            returns: {
                type : 'object',
                root : true
            } 
        });
        
        Intakeserreqrestitution.getrestitutionfilecontent = function(request)
        {
            let totalcount = 0;

            LOGGER.debug(request.where.contentid+"personid");
            var pagesize = request.limit;
            var pagenumber = request.page;


            var sql = "select * from getrestitutionfilecontent($1,$2,$3)";

            return util.executeDBQuery(sql,[request.where.contentid,pagenumber,pagesize])
                .then(data => {
                    if (data!==null && data.length>0) {
                        totalcount= data[0].totalcount;
                        var result;
                        result = {
                            'data' : data,
                            'count' : totalcount
                        };
                        return result;
                    }
                })
                .then(data => data)
                .catch(err => util.logError(err));
            };

            Intakeserreqrestitution.remoteMethod('getrestitutionpayment', {
                http: {
                    path: '/getrestitutionpayment',
                    verb: 'get'
                },
                accepts : [ 
                {
                    arg : 'filter',
                    type : 'object',
                    http : {source : 'query'}
                } ],  
                returns: {
                    type : 'object',
                    root : true
                } 
            });
            
            Intakeserreqrestitution.getrestitutionpayment = function(request)
            {
                LOGGER.debug(request.where.restitutionno+"personid");
                var pagesize = request.limit;
                var pagenumber = request.page;
                var nolimit = !!request.nolimit;


                var sql = "select * from getrestitutionpaymentlist($1,$2,$3,$4,$5)";

                return util.executeDBQuery(sql,[request.where.restitutionno,request.where.youthpersonid,pagenumber,pagesize,nolimit])
                    .then(withCount)
                    .catch(err => util.logError(err));
                };

                Intakeserreqrestitution.remoteMethod('getrestitutionpaymentapprove', {
                    http: {
                        path: '/getrestitutionpaymentapprove',
                        verb: 'get'
                    },
                    accepts : [ 
                    {
                        arg : 'filter',
                        type : 'object',
                        http : {source : 'query'}
                    } ],  
                    returns: {
                        type : 'object',
                        root : true
                    } 
                });
                
                Intakeserreqrestitution.getrestitutionpaymentapprove = function(request)
                {
                    let totalcount = 0;
                    var pagesize = request.limit;
                    var pagenumber = request.page;

                    var sql = "select * from getrestitutionpaymentapprove($1,$2,$3)";

                    return util.executeDBQuery(sql,[request.where.contentid,pagenumber,pagesize])
                        .then(data => {
                            if (data!==null && data.length>0) {
                                totalcount= data[0].totalcount;
                                var result;
                                result = {
                                    'data' : data,
                                    'count' : totalcount
                                };
                                LOGGER.debug(result)
                                return result;
                            }
                        })
                        .then(data => data)
                        .catch(err => util.logError(err));
                    };
            
                    Intakeserreqrestitution.getrestitutionchangeformdashboardlist = function(data, reqctx) {
                        const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;
                        var showCount = false;
                        var filtercol='';
                        var filtervalue='';
                        var obj = data.where;
                        if(data.page === 1){
                            showCount = true;
                        }/* else{showCount = false}; */         //SonarQube fix - commented as showCount is already set to false above

                        if (util.isNullorEmpty(obj))
                        {

                            if(Object.keys(obj)[0].toLowerCase() !=="activeflag")
                            {
                                filtercol =Object.keys(obj)[0] ;
                                var obj1 = obj[Object.keys(obj)[0]];
                                if (obj1 !==null && obj1 !==undefined)
                                {
                                    filtervalue=obj1;
                                }
                            }
                        }

                        var sql1 = 'select * from getrstnchangeformdashboardlist($1,$2,$3,$4,$5)';
                        return util.executeDBQuery(sql1,[_securityusersid,data.page,
                            data.limit,filtercol,filtervalue])
                            .then(data1 => stripCount(data1, showCount))
                            .catch(err => {
                                LOGGER.error('>>>>ERROR:', err);
                                throw err;
                            });

                    };
                
                    Intakeserreqrestitution.remoteMethod('getrestitutionchangeformdashboardlist', {
                        accepts : [{
                                arg : 'data',
                                type : 'object',
                                required : true,
                                http : { source: 'query' }
                            }, {
                                arg: 'reqctx',
                                type: 'object',
                                http: {source: 'context'}
                              }],
                        http: {
                            'verb': 'get', 
                            'path': '/getrestitutionchangeformdashboardlist'
                            },
                        returns : {
                            type : 'object',
                            root : true
                            }
                    });

                    Intakeserreqrestitution.getrestitutionccudashboardlist = function(data, reqctx) {
                        const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;
                        var showCount = false;
                        var filtercol='';
                        var filtervalue='';
                        var obj = data.where;
                        var status = data.where.status;
                        var nolimit = !!data.nolimit;
                        status = util.nullcheck(status);
                        if(data.page === 1){
                            showCount = true;
                        }/* else{showCount = false}; */         //SonarQube fix - commented as showCount is already set to false above

                        if (util.isNullorEmpty(obj))
                        {

                            if(Object.keys(obj)[0].toLowerCase() !=="activeflag")
                            {
                                filtercol =Object.keys(obj)[0] ;
                                var obj1 = obj[Object.keys(obj)[0]];
                                if (util.isNullorEmpty(obj1))
                                {
                                    filtervalue=obj1;
                                }
                            }
                        }

                        var sql1 = 'select * from getrstnccudashboardlist($1,$2,$3,$4,$5,$6,$7)';
                        return util.executeDBQuery(sql1,[_securityusersid,data.page,
                            data.limit,filtercol,filtervalue,status,nolimit])
                            .then(_data => stripCount(_data, showCount))
                            .catch(err => {
                                LOGGER.error('>>>>ERROR:', err);
                                throw err;
                            });

                    };
                
                    Intakeserreqrestitution.remoteMethod('getrestitutionccudashboardlist', {
                        accepts : [{
                                arg : 'data',
                                type : 'object',
                                required : true,
                                http : { source: 'query' }
                            }, {
                                arg: 'reqctx',
                                type: 'object',
                                http: {source: 'context'}
                              }],
                        http: {
                            'verb': 'get', 
                            'path': '/getrestitutionccudashboardlist'
                            },
                        returns : {
                            type : 'object',
                            root : true
                            }
                    });

                    Intakeserreqrestitution.remoteMethod('saverestitutionccuconfig', {
                        http: {
                                path: '/saverestitutionccuconfig',
                                verb: 'post'
                        },
                        accepts : [{arg : 'data',type : 'object',
                            http : {source : 'body'}
                        }, {
                            arg: 'reqctx',
                            type: 'object',
                            http: {source: 'context'}
                          } ],
                        returns: {
                            type : 'object',
                            root : true
                        }
                    
                    });
                    
                    Intakeserreqrestitution.saverestitutionccuconfig = (data, reqctx) => {
                        let _securityusersid = undefined;
                        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                          _securityusersid = reqctx.req.headers.securityusersid;
                        }  
                        const securityuserid = (data && data.securityuserid?data.securityuserid: _securityusersid);
                        var sql = 'SELECT * FROM saverestitutionccuconfig($1, $2)';
                        return util.executeDBQuery(sql, [JSON.stringify(data), securityuserid])
                       .then(_data => _data[0])
                       .catch(err => util.logError(err));
                    };

                    Intakeserreqrestitution.getrestitutionccunoteslist = function(data) {
                        var showCount = false;
                        var intakeserviceid = data.where.intakeserviceid;
                        if(data.page === 1){
                            showCount = true;
                        }/* else{showCount = false}; */ //SonarQube fix - commented as showCount is already set to false above

                        var sql1 = 'select * from getrstnccunoteslist($1,$2,$3)';
                        return util.executeDBQuery(sql1,[intakeserviceid, data.page,
                            data.limit])
                            .then(_data => stripCount(_data, showCount))
                            .catch(err => {
                                LOGGER.error('>>>>ERROR:', err);
                                throw err;
                            });

                    };
                
                    Intakeserreqrestitution.remoteMethod('getrestitutionccunoteslist', {
                        accepts : {
                                arg : 'data',
                                type : 'object',
                                required : true,
                                http : { source: 'query' }
                            },
                        http: {
                            'verb': 'get', 
                            'path': '/getrestitutionccunoteslist'
                            },
                        returns : {
                            type : 'object',
                            root : true
                            }
                    });

                    Intakeserreqrestitution.remoteMethod('restitutionsendtoccu', {
                        http: {
                                path: '/restitutionsendtoccu',
                                verb: 'post'
                        },
                        accepts : [{arg : 'data',type : 'object',
                            http : {source : 'body'}
                        }, {
                            arg: 'reqctx',
                            type: 'object',
                            http: {source: 'context'}
                          } ],
                        returns: {
                            type : 'object',
                            root : true
                        }
                    
                    });
                    
                    Intakeserreqrestitution.restitutionsendtoccu = (data, reqctx) => {
                        let _securityusersid = undefined;
                        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                          _securityusersid = reqctx.req.headers.securityusersid;
                        }  
                        const securityuserid = (data && data.securityuserid?data.securityuserid: _securityusersid);
                        var sql = 'SELECT * FROM restitutionsendtoccu($1, $2)';
                        return util.executeDBQuery(sql, [JSON.stringify(data), securityuserid])
                       .then(_data => _data[0])
                       .catch(err => util.logError(err));
                    };

                    Intakeserreqrestitution.remoteMethod('restitutionccuapprovereject', {
                        http: {
                                path: '/restitutionccuapprovereject',
                                verb: 'post'
                        },
                        accepts : [{arg : 'data',type : 'object',
                            http : {source : 'body'}
                        }, {
                            arg: 'reqctx',
                            type: 'object',
                            http: {source: 'context'}
                          } ],
                        returns: {
                            type : 'object',
                            root : true
                        }
                    
                    });
                    
                    Intakeserreqrestitution.restitutionccuapprovereject = (data, reqctx) => {
                        let _securityusersid = undefined;
                        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                          _securityusersid = reqctx.req.headers.securityusersid;
                        }  
                        const securityuserid = (data && data.securityuserid?data.securityuserid: _securityusersid);
                        var sql = 'SELECT * FROM restitutionccuapprovereject($1, $2)';
                        return util.executeDBQuery(sql, [JSON.stringify(data), securityuserid])
                       .then(data1 => data1[0])
                       .catch(err => util.logError(err));
                    };

    Intakeserreqrestitution.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeserreqrestitution.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeserreqrestitution.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
