var config = require('../../server/config.json');
const LOGGER = require("log4js").getLogger("user");
var path = require('path');
var senderAddress = "noreply@loopback.com"; //Replace this address with your actual address
const loopback = require('loopback');
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(User) {
    
  // Method to render
  User.afterRemote('prototype.verify', function(context, user, next) {
    context.res.render('response', {
      title: 'A Link to reverify your identity has been sent '+
        'to your email successfully',
      content: 'Please check your email and click on the verification link '+
        'before logging in',
      redirectTo: '/',
      redirectToLinkText: 'Log in'
    });
  });

  //send   reset link when requested
  User.on('resetPasswordRequest', function(info) {
    var url = 'http://' + config.host + ':' + config.port + '/reset-password';
    var html = 'Click <a href="' + url + '?access_token=' +
        info.accessToken.id + '">here</a> to reset your password';

    User.app.models.Email.send({
      to: info.email,
      from: senderAddress,
      subject: 'Password reset',
      html: html
    }, function(err) {
      if (err) {
        return LOGGER.debug('> error sending password reset email');}
      LOGGER.debug('> sending password reset email to:', info.email);
    });
  });

 
   
 
 
  
  
   
  
 

  
  User.afterRemote('login', (ctx, user, next) => {
    const result = JSON.parse(JSON.stringify(ctx.result));
    if(result) {
      const accessTokenId = result.id;
      let fromDevice = 1;
      if(ctx.req.body.fromdevice){
        fromDevice = ctx.req.body.fromdevice;
      }
      if(accessTokenId) {
        app.models.accessTkn.updateAll({id: accessTokenId}, {fromdevice: fromDevice})
        .then(data => {
          next();
        })
        .catch(err => {
          util.logError(err);
          next();
        });
      }
      else {
        next();
      }
  }
  else {
    next();
  }
		
  });

  User.afterRemote('login', function(ctx, user, next) {
    const result = JSON.parse(JSON.stringify(ctx.result));
    if(result && result.user) {
      const user1 = result.user;
      getUserProfileteam(user1.securityusersid)
      .then(data => {
        if(data.teamtypekey === 'CW'){
          data.ismanualrouting = true
        }
        result.user.userprofile = data;
        ctx.result = result;
        next();
      })
      .catch(err => util.logError(err));
    }
  else {
    next();
  }
		
  });




  const getUserProfileteam = securityid => {
    return app.models.Userprofile.findById(securityid, {
      include: [{
        relation: 'teammemberassignment',
        scope: {
          where: { activeflag: true },
          fields: ['teammemberid', 'securityusersid'],
          limit: 1,
          include: {
            relation: 'teammember',
            scope: {
              fields: ['teamid', 'teammemberid', 'loadnumber', 'roletypekey'],
              include: [{
                relation: 'team',
                scope: {
                  fields: ['teamid', 'name', 'teamtypekey', 'parentteamid','countyid'],
                  include: {
                    relation: 'teamtype',
                    scope: {
                      fields: ['teamtypekey', 'description']
                    }
                  }
                }
              },
              {
                relation: 'teammemberroletype',
                scope: {
                  fields: ['roletypekey', 'description','issupervisor']
                }
              }
              ]
            }
          }
        }
      },
      { relation: 'userprofilephonenumber' },
      { relation: 'userprofileaddress' }]
    })
      .then(data => data)
      .catch(err => util.logError(err));
  }


  User.afterRemote('setPassword', function(context, user, next) {
    context.res.render('response', {
      title: 'Password reset success',
      content: 'Your password has been reset successfully',
      redirectTo: '/',
      redirectToLinkText: 'Log in'
    });
  });

  User.remoteMethod('list', {
    http: {
      path: '/list',
      verb: 'get'
    },
    accepts : [{
      arg : 'filter',
      type : 'Object',
      required: true,
      http: {source: 'query'}
    }],
    description: "User List",
    notes: "User List",
    returns: {
      type : 'Object',
      root : true
    }
  });

  function validateinput(str) {
		if (str === 'undefined') {
			return null;
		} else {
			return str;
		}

	}

  User.list = data => {
		var sortby ='';
		var sortorder=''
		var filtercol='datype';
		var filtervalue='';
    var obj = data.where;
    var obj1 = null;
    if(!data.page){
      data.page = 0;}
    if(!data.limit){
      data.limit = 0;
    }
		if (obj != null && obj !== undefined)
		{
			if(Object.keys(obj)[0].toLowerCase() !== "activeflag")
			{
				filtercol =Object.keys(obj)[0] ;
				obj1 = obj[Object.keys(obj)[0]];
			}
		}
    if (obj1 !=null && obj1 !== undefined)
    {
      filtervalue=obj1[Object.keys(obj1)[0]];
    }


    var sordrby = data?.order?.trim().split(" ");
    if (sordrby?.length > 1)
    {
      sortby=  sordrby[0];
      sortorder = sordrby[sordrby.length-1];
    }


		var sql = 'select * from getuserlist($1,$2,$3,$4,$5,$6)';
		
		LOGGER.debug(data.page + '\',\'' + data.size + '\',\''+ validateinput(data.orderby));

    LOGGER.debug("SQL :" + sql);

    return util.executeDBQuery(sql,[data.page,data.limit,filtercol,filtervalue,sortby,sortorder])
  .then(data3 => {
    let totalCount = 0;
    if (data3.length>0 ) {
      totalCount = data3[0].totalcount;}

    data3.forEach(x => delete x.totalcount);
    return {data: data3,
         count: totalCount};
  })
  .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

  
  
  User.remoteMethod('userupdate', {
    http: {
        path: '/userupdate',
        verb: 'post'
    },
    accepts: [
        { arg: 'data', type: 'object', http: { source: 'body' } }],
    returns: {
        type: 'string',
        root: true
    }
});
  User.userupdate = (request, reqctx) => {

    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
    var securityuserid = app.currentUser.userprofile.securityusersid;
    const userId = request.userId;
    const supervisoid = request.supervisoid;
    const ssn = request.ssn;
    var sql = 'update userprofile set ' +
    ' supervisorid = $1, ' +
    ' ssn = $2, updatedon = now(), updatedby = $4 '+
    ' where securityusersid = $3';
    return util.executeDBQuery(sql, [supervisoid,ssn,userId,securityuserid])
        .then(data => {
            if (data != null && data.length) {
                return data;
            } else {
                return null;
            }
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

};

  User.remoteMethod ('createuser', {
    http: {
        path: '/createuser',
        verb: 'post'
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
  }, {
    arg: 'reqctx',
    type: 'object',
    http: {source: 'context'}
    }],
    returns: {
        arg: 'data', 
        type: 'Object'
    }
  });

  User.createuser = request => {
    let user = {};
    return User.create(request)
    .then(data => {  
      user = data;
      const principalid = data.id.toString();
    
      const prs = [];
      prs.push(app.models.Rolemapping.updateAll({principalid: principalid}, {activeflag: 0}));
      prs.push(app.models.Rolemapping.create({
        principaltype: 'USER', principalid: principalid, roleid: request.roleid,
        insertedby: (request && request.securityuserid  ? request.securityuserid  : _securityusersid),
        updatedby: (request && request.securityuserid  ? request.securityuserid  : _securityusersid)
      }));
      return Promise.all(prs);
    })
    .then(data => {
      return {
        user: user,
        rolemapping: data[1]
      };
    })
    .catch(err => util.logError(err));
  }

  User.remoteMethod ('updateuser', {
    http: {
        path: '/updateuser',
        verb: 'post'
    },
    accepts: {
        arg: 'data', 
        type: 'Object',
        http: {
          source: 'body'
        }
    },
    returns: {
        arg: 'data', 
        type: 'Object'
    }
  });

  User.updateuser = request => {

    const userid = request.where.principalid;
    const principalid = userid;
    const roleid = request.where.roleid;
    const plainPassword = request.where.password;
    var _securityusersid; //teammemberids;
    const prs = [];

    prs.push(app.models.Rolemapping.updateAll({principalid: principalid}, {activeflag: 0}));
    prs.push(app.models.Rolemapping.create({
      principaltype: 'USER', principalid: principalid, roleid: roleid,
      insertedby: (request && request.securityuserid  ? request.securityuserid  : _securityusersid),
      updatedby: (request && request.securityuserid  ? request.securityuserid  : _securityusersid)
    }));
    // return app.models.User.findOne({
    //   where:{id:userid},
    //   fields:['securityusersid']
    // }).then(res =>{
    //   _securityusersid = res.securityusersid;
    // }).then(data =>{
    //   return app.models.Teammemberassignment.find({
    //     where:{
    //       securityusersid:_securityusersid
    //     },
    //     fields:['teammemberid']
    //   })
    // }).then(result => {
    //   if(result.length > 0)
    //     teammemberids =  result[0].teammemberid;
    //     if(teammemberid !== teammemberids){
    //       prs.push(app.models.Teammemberassignment.updateAll( {securityusersid:_securityusersid},{activeflag:0}));
    //       prs.push(app.models.Teammemberassignment.create({
    //         teammemberid:teammemberid,
    //         securityusersid:_securityusersid
    //       }))
    //     }
      if(plainPassword){
        prs.push(app.models.User.setPassword(userid, plainPassword));}
      return Promise.all(prs)
      .then(data => {
        return data[1];
      }).catch(err => util.logError(err));
      }

  /*For Listing Security Users Details*/


  User.remoteMethod('getuser', {
    http: {
      path: '/getuser/:id',
      verb: 'get'
    },
    accepts : [{
      arg: 'id',
      type: 'number',
      required: true,
      http: {source: 'path'}
    },{
      arg : 'filter',
      type : 'Object',
      required: false,
      http: {source: 'query'}
    }],
    description: "User List",
    notes: "User List",
    returns: {
      type : 'Object',
      root : true
    }
  });


  User.getuser = (id, request) => {
    let gUser = {};
    let userid ;
    return app.models.User.findById(id, {
      fields: [],
      include: {
        relation: 'userprofile',
        scope: {
          include: [{
            relation: 'userprofileaddress'
          },
          {
            relation: 'userprofilephonenumber'
          },
          {
            relation: 'usertype'
          },
          {
            relation: 'userworkstatustype'
          },
          {
            relation : 'userprofileidentifier'
          },{
            relation:'teammemberassignment',
            scope:{
              fields:['teammemberid'],
              limit: 1,
              include:{
                relation:'teammember',
                 scope:{
                    fields:['teamid','teammemberid','loadnumber'],
                    include:{
                      relation:'team',
                      scope:{
                        fields:['teamid','name','teamtypekey'],
                        include:{

                          relation:'teamtype',
                          scope:{
                            fields:['teamtypekey','description']
                          }
                        }
                      }
                    }
                 }
                }
            }  
          }
        ]
        }
      }
    })
    .then(data => {
      gUser = data; 
      userid =data.id;
      return app.models.Authorize.findRole(data.id);
    })
    .then(data => {
      if(data.length > 0){
        gUser.role = data[0];
      }   
      return app.models.Userprofile.findPg(userid);   
    }).then(userresource=>{
      gUser.userresource = userresource;
      return gUser;
    })
    .catch(err => util.logError(err));
  };

  User.remoteMethod('getcurrentuser', {
    http: {
      path: '/getcurrentuser',
      verb: 'get'
    },
    accepts : [{
      arg : 'filter',
      type : 'Object',
      required: false,
      http: {source: 'query'}
    },
    {
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
    }],
    description: "Current user details",
    notes: "Current user details",
    returns: {
      type : 'Object',
      root : true
    }
  });

  User.getcurrentuser = (request, reqctx) => {
    var _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
      _email = reqctx.req.headers.user_email_captureby_application;
		}  
    var requestuserinfo = {'token': '', 'email': _email};
    return util.getuserinfo(requestuserinfo)
		.then(data => {
			if(data){
			const userid = data.id;
      return User.getuser(userid, request);
      }
    });
  };

  User.getcaseworkers = (request) => {
    var roleid = 2; //Case Worker Role
    return app.models.Rolemapping.find({
      where: {roleid: roleid},
      fields: ['roleid', 'principalid']
    })
    .then(users => {
      const prs = [];
      prs.push(users.map(user => {
        const userid = parseInt(user.principalid);
        return User.getuser(userid, request);
      }));
      const flatPrs = prs.reduce((a, b) => a.concat(b), []);
      return Promise.all(flatPrs);
    })
    .then(result => {
      const data = JSON.parse(JSON.stringify(result));
      return data.filter(user => user.userprofile);
    })
    .catch(err => util.logError(err));
  };
  
  User.remoteMethod('getcaseworkers', {
    http: {
      path: '/getcaseworkers',
      verb: 'get'
    },
    accepts : [{
      arg : 'filter',
      type : 'Object',
      required: false,
      http: {source: 'query'}
    }],
    description: "Get Users with role as case workers",
    notes: "Get Users with role as case workers",
    returns: {
      type : 'Object',
      root : true
    }
  });

  User.logout = (tokenId,securityusersid) => {
    const currentDate = new Date().toLocaleString();
    if (!tokenId) {
      tokenId = app.headers.access_token;}
    if (!tokenId) {
      return new Promise((resolve, reject) => {
        return reject("{{accessToken}} is required to logout");
      });
    }

    return app.models.accessTkn
    .updateAll({id:tokenId}, {activeflag: 0, updatedby:securityusersid, updatedon: currentDate})
    .then(data => {
      return data;
    })
    .catch(err => {
      return util.logError(err);
    });
  };


  User.remoteMethod('logout', {
    http: {
      path: '/logout',
      verb: 'post'
    },
    accepts : [{arg: 'access_token', type: 'string', http: function(ctx) {
      var req = ctx && ctx.req;
      var accessToken = req && req.headers;

      return  accessToken.access_token ?  accessToken.access_token : undefined;
    }, description: 'Do not supply this argument, it is automatically extracted ' +
      'from request headers.',
    }, {
      arg: 'securityusersid', type: 'string', http: function(ctx) {
        var req = ctx && ctx.req;
        var accessToken = req && req.headers;

        return  accessToken.securityusersid ?  accessToken.securityusersid : undefined;
      }, description: 'Do not supply this argument, it is automatically extracted ' +
        'from request headers.',
      }],
    description: "Overridden logout",
    notes: "Overridden logout method",
    returns: {
      type : 'Object',
      root : true
    }
  });
  User.remoteMethod('getuserprofilebyid', {
    http: {
      path: '/getuserprofilebyid',
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

	
  User.getuserprofilebyid = request =>
    util.executeDBQuery('select * from getuserprofilebyid($1)', [request.where.securityuserid])
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

  

  User.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  User.observe('access', (ctx, next) => util.access(ctx, next));
  User.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};