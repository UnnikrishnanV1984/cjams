'use strict';
const LOGGER = require("log4js").getLogger("userprofile");

var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Userprofile) {
var teammemberids;
    Userprofile.remoteMethod('updatestatus', {
        http: {
                path: '/updatestatus',
                verb: 'patch'
        },
        accepts : [
            {
                arg : 'data',
                type : 'object',
                http : {source : 'body'}
            },{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  }],
        returns: {
            type : 'object',
            root : true
        }
    });

		
		Userprofile.writelog = (msg) => {
			const fs = require('fs');
			fs.appendFile('log\access_token.txt', Date.now() + ' : ' + msg + " \r\n", (err)=>{
              LOGGER.debug('Failed to append access_token', err);
            });
		}

    Userprofile.updatestatus = (arg,reqctx) => {
		let suserid=undefined;
		if(reqctx && reqctx.req &&reqctx.req.headers){
		  suserid=reqctx.req.headers.securityusersid
		}
        const securityusersid = arg.securityusersid ? arg.securityusersid :  suserid;        
        
        return Userprofile.updateAll({securityusersid: securityusersid}, {userworkstatustypekey: arg.userworkstatustypekey, isavailable: arg.isavailable, updatedby: arg && arg.securityuserid ? arg.securityuserid: suserid})
        .then(data => data)
        .catch(err => err);
		};
		
		Userprofile.updatephoto = (arg,reqctx) => {
			let suserid=undefined;
			if(reqctx && reqctx.req &&reqctx.req.headers){
			  suserid=reqctx.req.headers.securityusersid
			}
			const securityusersid = arg.securityusersid ? arg.securityusersid :  suserid;        
			
			// The header posts back the value it was rendering, which is prefixed for
			// display -- store the bare relative path so it cannot accumulate.
			return Userprofile.updateAll({securityusersid: securityusersid}, {userphoto: util.apiResourcePath(arg.userphoto), updatedby: arg && arg.securityuserid ? arg.securityuserid: suserid })
			.then(data => data)
			.catch(err => err);
	};

	Userprofile.remoteMethod('updatephoto', {
		http: {
						path: '/updatephoto',
						verb: 'post'
		},
		accepts : [
				{
						arg : 'data',
						type : 'object',
						http : {source : 'body'}
				},{
					arg: 'reqctx',
					type: 'object',
					http: {source: 'context'}
				  }],
		returns: {
				type : 'object',
				root : true
		}
});

	Userprofile.remoteMethod('addupdate', {
		http: {
				path: '/addupdate',
				verb: 'post'
		},
		accepts : [ {arg : 'data',type : 'object',
			http : {source : 'body'}} ,{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  }],   
			 returns: {
			type : 'object',
			root : true
		}});
	Userprofile.addupdate =(request,reqctx) =>{
		const suserid=util.getSecurityDetails(request, reqctx).securityuserid;
		    const insertedby = suserid;
			const updatedby = suserid;
			const user = request.User;
			var userid = request.User.securityusersid;
			let prs = [];
			var nowDate = new Date();
			let getuser ={};
				  return app.models.Userprofile.upsert(
					{
						securityusersid:user.securityusersid,
						firstname:user.firstname,
						lastname:user.lastname,
						displayname:user.displayname,
						fullname:user.fullname,
						email:user.email,
						title:user.title,
						isavailable:user.isavailable,
						userworkstatustypekey:user.userworkstatustypekey,
						usertypekey:user.usertypekey,
						calendartypekey:user.calendartypekey, 
						autonotification :user.autonotification,
						orgname:user.orgname,
						orgnumber:user.orgnumber,
						insertedby : insertedby,
						middlename:user.middlename,
						gendertypekey:user.gendertypekey,
						dob:user.dob,
						userphoto : user.userphoto,
						teamtypekey : user.teamtypekey,
						jobtitlecd : user.jobtitlecd,
						primarycountyid :user.primarycountyid,
						updatedby : insertedby, 
						updatedon : nowDate.toJSON()
			})	.then(data => {
						getuser = data;
				   
						userid = data.securityusersid; 
					  const userprofileidentifier =  request.Userprofileidentifier;
				
						if(Array.isArray(userprofileidentifier)){
							userprofileidentifier.forEach(userprofileidentifier1 => userprofileidentifier1.securityusersid = userid);
							 prs.push(
								userprofileidentifier.map(newuserprofileidentifier =>{ 
							 if(newuserprofileidentifier.userprofileidentifierid !== null 
							 && newuserprofileidentifier.userprofileidentifierid !== undefined){
							 return app.models.Userprofileidentifier.upsert(
										{
											userprofileidentifierid:newuserprofileidentifier.userprofileidentifierid,
											securityusersid:newuserprofileidentifier.securityusersid,
											userprofileidentifiertypekey:newuserprofileidentifier.userprofileidentifiertypekey,
											userprofileidentifiervalue:newuserprofileidentifier.userprofileidentifiervalue,
											updatedby : insertedby
									  })}else{
										return app.models.Userprofileidentifier.upsert(
											{

												securityusersid:newuserprofileidentifier.securityusersid,
												userprofileidentifiertypekey:newuserprofileidentifier.userprofileidentifiertypekey,
												userprofileidentifiervalue:newuserprofileidentifier.userprofileidentifiervalue,
												insertedby : insertedby
										  })
									  }
									})
							  );  
					}	
				const Userprofileaddress = request.Userprofileaddress;				
			   if(Userprofileaddress.userprofileaddressid !== null 
							&& Userprofileaddress.userprofileaddressid !== undefined && Userprofileaddress.securityusersid === userid ){
					prs.push( app.models.Userprofileaddress.upsert(
						   {  
							userprofileaddressid:Userprofileaddress.userprofileaddressid,
							securityusersid:Userprofileaddress.securityusersid,
							userprofileaddresstypekey:Userprofileaddress.userprofileaddresstypekey,
							address:Userprofileaddress.address,
							pobox:Userprofileaddress.pobox,
							city:Userprofileaddress.city,
							state:Userprofileaddress.state, 
							zipcode:Userprofileaddress.zipcode,
							country:Userprofileaddress.country,
							county:Userprofileaddress.county,
							countyid:Userprofileaddress.countyid,
							updatedby : insertedby
		 }))
						}else{
							prs.push(app.models.Userprofileaddress.upsert(
								{  								 
								 securityusersid:userid,
								 userprofileaddresstypekey:Userprofileaddress.userprofileaddresstypekey,
								 address:Userprofileaddress.address,
								 pobox:Userprofileaddress.pobox,
								 city:Userprofileaddress.city,
								 state:Userprofileaddress.state, 
								 zipcode:Userprofileaddress.zipcode,
								 country:Userprofileaddress.country,
								 county:Userprofileaddress.county,
								 countyid:Userprofileaddress.countyid,
								 insertedby : insertedby
								  }))
						}

						const Userprofilephonenumber = request.Userprofilephonenumber;
				 prs = AddUpdateUserprofilephonenumber(Userprofilephonenumber, prs, userid, insertedby);
			   if(user.securityusersid == null){					
				   prs.push(						
						   app.models.Securityusers.create(
							   {
								   securityusersid : userid,
								   username : user.lastname,
								   insertedby : insertedby,
								   updatedby : updatedby,
							   }
						   )
			   );
		   }else if(user.securityusersid !== null){							
			   prs.push(						
					   app.models.Securityusers.upsert(
						   {
							   securityusersid : user.securityusersid,
							   username : user.lastname,
							   insertedby : insertedby
						   }
					   )
		   );
		   }
			   prs = findUpdateTeammemberassignment(request, userid, insertedby, prs);
			var flatPrs = prs.reduce((a,b) => a.concat(b), []);
			return Promise.all(flatPrs)
	 }).then (data => {
			 const returndata = {};
			 returndata.data = data;
			 returndata.user = getuser;
			 return  returndata;
		   }) .catch(err => util.logError(err))          	
		}

	function AddUpdateUserprofilephonenumber(Userprofilephonenumber, prs, userid, insertedby) {
		if (Array.isArray(Userprofilephonenumber)) {
			Userprofilephonenumber.forEach(Userprofilephonenumber1 => Userprofilephonenumber1.securityusersid = userid);
			prs.push(
				Userprofilephonenumber.map(newuserprofilephonenumber => {
					if (newuserprofilephonenumber.userprofilephonenumberid !== null
						&& newuserprofilephonenumber.userprofilephonenumberid !== undefined) {
						return app.models.Userprofilephonenumber.upsert(
							{
								userprofilephonenumberid: newuserprofilephonenumber.userprofilephonenumberid,
								securityusersid: newuserprofilephonenumber.securityusersid,
								userprofiletypekey: newuserprofilephonenumber.userprofiletypekey,
								phonenumber: newuserprofilephonenumber.phonenumber,
								reversephonenumber: newuserprofilephonenumber.reversephonenumber,
								phoneextension: newuserprofilephonenumber.phoneextension,
								updatedby: insertedby
							}
						)
					} else {
						return app.models.Userprofilephonenumber.upsert(
							{

								securityusersid: newuserprofilephonenumber.securityusersid,
								userprofiletypekey: newuserprofilephonenumber.userprofiletypekey,
								phonenumber: newuserprofilephonenumber.phonenumber,
								reversephonenumber: newuserprofilephonenumber.reversephonenumber,
								phoneextension: newuserprofilephonenumber.phoneextension,
								insertedby: insertedby,
								updatedby: insertedby
							}
						)
					}
				})
			);
		}
		return prs;
	}

		function findUpdateTeammemberassignment(request, userid, insertedby, prs){
			var teammemberid = request.teammemberid;
			if(request.teammemberid !== undefined){
				app.models.Teammemberassignment.find({
					where:{
						teammemberid: request.teammemberid
					}
				}).then(result => {
				 
					if(result.length > 0){
						app.models.Teammemberassignment.find({
								where:{
								securityusersid:userid
								},
								fields:['teammemberid']
							})
							.then(result1 => {
							if(result1.length > 0){
								teammemberids =  result1[0].teammemberid;}
								if(teammemberid !== teammemberids){
								prs.push(app.models.Teammemberassignment.updateAll( {securityusersid:userid},{activeflag:0}));
								prs.push(app.models.Teammemberassignment.create({
									 teammemberid:teammemberid,
									 securityusersid:userid,
									 insertedby:insertedby,
									 updatedby: insertedby
								 }))
								}
							})
					}else{
						prs.push(app.models.Teammemberassignment.updateAll( {teammemberid:request.teammemberid},{activeflag:0}));
						prs.push(app.models.Teammemberassignment.create({
							teammemberid:request.teammemberid,
							securityusersid:userid,
							insertedby:insertedby,
							updatedby: updatedby
							}))
					}
			})
		 }
		 return prs;
		}
	Userprofile.remoteMethod('list', {
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
			http: {"verb": "get", "path": "/list/:id"},
		returns : {
			type : 'Object',
			root : true
		}
		}); 
                       
                       
	Userprofile.list = function (id,arg) {
		var county;
		var data, res, dataresp, result, resp, reslt;
		var sql = 'SELECT securityusersid,firstname,lastname,displayname,fullname,activeflag,email,title,calendarkey,orgname,orgnumber,usertypekey,insertedon,autonotification,unavailableflag,  userworkstatustypekey  FROM userprofile WHERE securityusersid = $1';
		return util.executeDBQuery(sql,[id])
			.then(userdata => {
				data = userdata;
				var sql1 = 'SELECT userprofileaddressid, address,zipcode,pobox,city,state,country,zipcodeplus,county  FROM userprofileaddress WHERE securityusersid = $1';
				return util.executeDBQuery(sql1,[id]);
			})
			.then(addressdata => {
				res = addressdata;
				if (res.length > 0) {
					county = res[0].county;
				}
				var sql6 = 'SELECT fipscode, locationcode  FROM county WHERE countyname = $1';
				return util.executeDBQuery(sql6,[county]);
			})
			.then(countydata => {
				dataresp = countydata;
				var sql2 = 'SELECT userprofileidentifierid,userprofileidentifiertypekey,userprofileidentifiervalue  FROM userprofileidentifier WHERE securityusersid = $1';
				return util.executeDBQuery(sql2,[id]);
			})
			.then(iddata => {
				result = iddata;
				var sql3 = 'SELECT userprofilephonenumberid,userprofiletypekey,phonenumber,phoneextension,reversephonenumber  FROM userprofilephonenumber WHERE securityusersid = $1';
				return util.executeDBQuery(sql3,[id]);
			})
			.then(phonedata => {
				resp = phonedata;
				var sql4 = 'SELECT username  FROM  securityusers  WHERE securityusersid = $1';
				return util.executeDBQuery(sql4,[id]);
			})
			.then(userndata => {
				reslt = userndata;
				var sql5 = 'SELECT teammemberid  FROM  teammemberassignment  WHERE securityusersid = $1';
				return util.executeDBQuery(sql5,[id]);
			})
			.then(respond => {
				var _teammemberid;
				if (respond.length > 0) {
					_teammemberid = respond[0].teammemberid;
				}
				return findTeammember(_teammemberid, data, res, result, resp, reslt, dataresp);
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
	}

	function findTeammember(_teammemberid, data, res, result, resp, reslt, dataresp){
		const responseJson = {};
		return app.models.Teammember.find({
			where: {
				teammemberid: _teammemberid
			}
		}).then(rsult => {
			var _teamid = rsult[0].teamid;
			return app.models.Team.find({
				where: {
					teamid: _teamid
				}
			}).then(datares => {
				responseJson.userdetails = data[0];			//SonarQube fix replaced ',' with ";"
				responseJson.addressdetails = res[0];
				responseJson.iddetails = result;
				responseJson.phonedetails = resp;
				responseJson.networkid = reslt[0];
				responseJson.positioncode = rsult[0];
				responseJson.teamdetails = datares[0];
				responseJson.countydetails = dataresp[0];
				return responseJson;
			});
		});
	}
						 
	Userprofile.remoteMethod ('generateAccessToken', {
	http: {
		path: '/generateAccessToken',
		verb: 'post'
	},
	accepts: {
		arg: 'User', 
		type: 'Object',
		http: {
			source: 'body'
		}
	},
	returns: {
			type: 'Object',
			root: true
	}
	});

	Userprofile.getUserProfile =request => {
	return app.models.Userprofile.findOne({
		where:{securityusersid: user.securityusersid}
	})
	}

	Userprofile.generateAccessToken = request=> {
	
	if(app.currentUser!==null && app.currentUser.email!==null){
		request.email = app.currentUser.email;}
	var respjson ={};
	Userprofile.writelog('Create session for user <' + request.email + '>');
	return app.models.User.findOne({
		where:{email: request.email}
	}).then(user => {
		if(!user) { 
            return null;
		}
		return app.models.user.findById(user.id ,{
			include :{
				relation : 'userprofile',
				scope:{
				include:[{
				relation : 'teammemberassignment',
				scope:{
					fields:['teammemberid','securityusersid'],
					limit: 1,
					include:{
					relation:'teammember',
						scope:{
						fields:['teamid','teammemberid','loadnumber','roletypekey', 'supervisorid'],
						include:[{
							relation:'teammemberroletype',
							scope:{
							fields:['roletypekey','description']
							}
						},{
							relation:'team',
							scope:{
								fields:['teamid','name','teamtypekey','countyid', 'parentteamid'],
								include:[{
								relation:'teamtype',
								scope:{
									fields:['teamtypekey','description']
								}
								}
								,{
								relation: 'county',
								scope:{
									fields: ['countyid','countyname', 'countycode']
								}
								}]
							}
							}]
						}
					}
					}
				},
				{relation: 'userprofilephonenumber'}, 
				{relation: 'userprofileaddress'}]
				}
			}
			}
			
		);
		}).then(result => {
			if(result) {	
			respjson.user = result;
				return app.models.AccessToken.create({
					"userId": result.id,
					"ttl":3600
				}).then(token => {
					Userprofile.writelog('Access Token created - ' + token.id + ' for userid - ' + token.userid);
					
					respjson.ttl = token.ttl;
					respjson.id = token.id;
					respjson.created = token.created;
					respjson.userId = token.userId;
					// return respjson;
					return util.encryptresponse(respjson);
				}); 
			} else {
				return {'error' : 'Not Found User'};
			}
	})
	
	}
			  
	Userprofile.remoteMethod('updateusersignature', {
	http: {
			path: '/updateusersignature',
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
		type : 'object',
		root : true
	}});

					   
    Userprofile.updateusersignature = (arg,reqctx) => {
		let suserid=undefined;
		if(reqctx && reqctx.req &&reqctx.req.headers){
		  suserid=reqctx.req.headers.securityusersid
		}
        const securityusersid = arg.securityusersid ? arg.securityusersid :  suserid;        
        
        return Userprofile.updateAll({securityusersid: securityusersid}, {usersignatureurl : arg.usersignatureurl, updatedby: arg && arg.securityuserid ? arg.securityuserid: suserid})
        .then(data => data)
        .catch(err => util.logError(err));
	};
	
	Userprofile.remoteMethod('listusersignature', {
		accepts : {
		arg : 'filter',
		type : 'Object',
		http : {
		source : 'query'
		},
		required : true
		},
		http : {
		path: '/listusersignature',
		verb : 'get'
		},
		returns : {
		type : 'Object',
		root : true
		}
		});

		Userprofile.listusersignature = (arg) => {
			return Userprofile.findOne({
				where:{
					securityusersid: arg.securityusersid 
				},
				fields:['usersignatureurl','securityusersid']
			   }).then(data =>{
				   return data;
			   })
		};

		Userprofile.remoteMethod('pgrolemapping', {
			http: {
			path: '/pgrolemapping',
			verb: 'put'
			},
			accepts : [ {arg : 'data',type : 'object',
			http : {source : 'body'}},
			{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			}],
			returns: {
			type : 'string',
			root : true
			}
			});

		Userprofile.pgrolemapping = (request, reqctx) => {
			const suserid=util.getSecurityDetails(request, reqctx).securityuserid;
			const insertedby = suserid;
			const updatedby = suserid;
			var pg = [];
			pg = request.pg;
			var principalid = request.userid.toString();
			var	roletypekey;
			var securityusersid;
			var teammemberid;
			var teamtypekey;

			return app.models.Rolemapping.count({
				and: [{principalid: principalid}, {roleid:request.roleid}]
			})
			.then(resrolecount => { 
					return app.models.Role.find({
						fields: ['roletypekey'],
						where: {
							id: request.roleid,
							activeflag: 1
						}
					}).then(res => {
						roletypekey = res ? res[0].roletypekey : null
						var team = roletypekey.indexOf('OLM') !== -1 ? 'OLM' : 'CW';
						return  app.models.user.find({
							fields:['securityusersid'],
						where:{
							id:principalid,
							activeflag: 1
						}
						}).then(res1 => {
							securityusersid = res1 ? res1[0].securityusersid : null;
							return app.models.Teammemberroletype.find({
								fields: ['teamtypekey'],
								where: {
									roletypekey: roletypekey,
									activeflag: 1
								}
							}).then(result => {
								teamtypekey = result ? result[0].teamtypekey : null
								return app.models.Userprofile.updateAll(
									{ securityusersid: securityusersid },
									{
										teamtypekey: teamtypekey
									}).then(res2 => {

							return app.models.Teammemberassignment.find({
								fields:['teammemberid'],
							where:{
								securityusersid:securityusersid
							}
							}).then( result1 => {
								teammemberid = getTeammemberId(result1);
								return app.models.Teammember.updateAll(
									{ teammemberid: teammemberid },
									{
										roletypekey: roletypekey
									}).then(result2=>{
										return app.models.Rolemapping.updateAll(
											{ principalid: principalid ,teamtypekey:team },
											{
												activeflag: 0
											}).then (x1=>{ 
											return app.models.Rolemapping.create({
												principaltype: 'USER',principalid: principalid,roleid: request.roleid,teamtypekey:team
											}).then(x=>{
												updateUserresource(pg,principalid, request, insertedby, updatedby);
												return x;
											});
										});

									});
							}) 
						})
						
					})
				})	
			
			})
			 
		}).catch(err=>util.logError(err));
	}

	function getTeammemberId(result1){
		return result1?result1[0].teammemberid:null;
	}
	function updateUserresource(pg,principalid, request, insertedby, updatedby) {
		var prs = [];
		app.models.Userresource.update({ userid: principalid },{ activeflag: 0 })
		if (Array.isArray(pg)) {
			pg.forEach(element => {
				prs.push(
					app.models.Userresource.create({
						userid: principalid,
						permissiongroupid: element,
						roleid: request.roleid,
						isallowed: true,
						insertedby: insertedby,
						updatedby: updatedby
					})
				)
			})
			return Promise.all(prs)
		}
	}

	Userprofile.findPg = (userid) => {
		return app.models.Userresource.find({
			where:{
				userid: userid 
			}
			}).then(data =>{
				return data; 
			})
			.catch(err => util.logError(err));
	}

		Userprofile.continuesession = (request) => {
			return Promise.resolve({'msg':'session extended'})
		};
	
		Userprofile.remoteMethod(
			'continuesession', {
				http: {
					path: '/continuesession',
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

		Userprofile.saveSupervisor = function(request,reqctx)
        {
			var supervisorID = request.supervisorID;
			var id = request.id;
			let suserid=undefined;
			if(reqctx && reqctx.req &&reqctx.req.headers){
			  suserid=reqctx.req.headers.securityusersid
			}
			const securityusersid = request.securityusersid ? request.securityusersid :  suserid;
            const sql = 'update userprofile set supervisorid = $1, updatedon = now(), updatedby = $3 where securityusersid in ( select securityusersid from muser where id=$2 )';
            return util.executeDBQuery(sql,[supervisorID,id,securityusersid])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
       };


    // to get the provider maintainance  detail 
    Userprofile.remoteMethod('saveSupervisor', {
        http: {
                path: '/saveSupervisor',
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

	Userprofile.remoteMethod('getusersbycountyids', {
			http: {
				path: '/getusersbycountyids',
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

    Userprofile.getusersbycountyids = request => {

        const sql = 'select * from cjams.getsupervisorsbycountyids($1)';

        return util.executeDBQuery(sql, [request.where.countyids])
            .then(data => data[0].getsupervisorsbycountyids)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

	Userprofile.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Userprofile.observe('access', (ctx, next) => util.access(ctx, next));
	Userprofile.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};