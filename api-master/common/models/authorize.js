'use strict';
const LOGGER = require("log4js").getLogger("authorize");
const app = require('../../server/server');
const loopback = require('loopback');
const boot = require('loopback-boot');
const util = require('../utils/utils');
const _ = require('lodash');
const commonapi = require('../models/commonapi');

module.exports = function(Authorize) {

	const RoleOrPage = {
		Role: 1,
		Page: 2
	};

	const PermissionType = {
		PermissionGroup: 1,
		Resource: 2
	};

	Authorize.findRole = userid => app.models.Rolemapping.find({
		where: {principalid: '' + userid},
		nolimit:true,
		fields: ["roleid","teamtypekey"], 
		include: {
			relation: 'role',
			scope: {
				fields: ['id', 'name', 'description']
			}
		}
	});

	const extractRoleFromRM = rmlist => {
        const roles = rmlist.map(rm1 => {
            const rm = JSON.parse(JSON.stringify(rm1));
            rm.role['teamtypekey'] = rm.teamtypekey;
            return rm.role;
        });
        LOGGER.debug(roles);
        let role = roles.filter(item => item.teamtypekey === 'CW');
        role = role.length>0 ? role[0]: null;
        return new Promise((resolve, reject) => {
            role==null?reject(new Error("No roles assigned for this user")):resolve(role);
        });
    };

	const roleResourceSearchTemplate = {
		fields: ['resourceid', 'isallowed', 'isvisible', 'isenabled'],
		nolimit:true,
		where: {
			and: [
				//{isvisible: true},
				//{isallowed: true}
				{activeflag: 1}
			]
		},
		include: {}
	};
	
	const roleResourceRelationTemplate = {
		relation: 'resource',
		scope: {
			// where: {
			// 	resourcetype: {inq: []}
			// },
			where: {
				and: []
			},
			nolimit:true,
			fields: ['id', 'parentid', 'name', 'resourcetype', 'resourceid', 'modulekey','description','parentkey']
		}
	};

	//Assign Userresource fields to const variable 
	const userResourceSearchTemplate = {
		fields: ['permissiongroupid', 'isallowed', 'isvisible', 'isenabled'],
		nolimit:true,
		where: {
			and: [ 
				{activeflag: 1}
			]
		},
		include: {}
	};
	
	const getRoleResourceRelationTemplate = (paramRoleResourceRelationTemplate, isRolePage, parentKey, moduleKey) => {
		const roleResourceRelationTemplateObj = JSON.parse(JSON.stringify(paramRoleResourceRelationTemplate));
		const resouceTypeIncludes = isRolePage == RoleOrPage.Role? [1,2,5]: [2, 3, 4];
		roleResourceRelationTemplateObj.scope.where.and.push({resourcetype: {inq: resouceTypeIncludes}});
		if (parentKey) {
			roleResourceRelationTemplateObj.scope.where.and.push({or: [{resourceid: parentKey}, {parentkey: parentKey}, {modulekey: moduleKey}]});
		}
		
		return roleResourceRelationTemplateObj;
	};

	const getRolePermissionGroupRelationTemplate = (paramRoleResourceRelationTemplate, isRolePage) => {
		return {
			relation: 'permissiongroup',
			scope: {
				fields: ['permissiongroupid'],
				include: {
					relation: 'pgresource',
					scope: {
						fields: ['permissiongroupid', 'resourceid', 'isallowed', 'isvisible', 'isenabled'],
						//where: {isallowed: true},
						//where: {activeflag: 1},
						where: {and: [{activeflag: 1}]},
						nolimit:true,
						include: paramRoleResourceRelationTemplate
					}
				},
			where: {and: [{permissiongroupname: {nlike: "%PG"} }, {permissiongroupname: {nlike: "%PGRead"} }, {permissiongroupname: {nlike: "%PGWrite"} }, {permissiongroupname: {nlike: "%PGNo Acess"} }]}
			}
		};
	};

	const getRoleResourceRelationObj = (roleid, permissiontype, isRolePage, parentKey, moduleKey) => {
		const roleResourceSearchObj = JSON.parse(JSON.stringify(roleResourceSearchTemplate));
		roleResourceSearchObj.where.and.push({roleid: roleid});
		roleResourceSearchObj.where.and.push({permissiontype: permissiontype});

		const roleResourceRelationTemplateRolePage = getRoleResourceRelationTemplate(roleResourceRelationTemplate, isRolePage, parentKey, moduleKey);

		if (permissiontype == PermissionType.PermissionGroup) {
			roleResourceSearchObj.include = getRolePermissionGroupRelationTemplate(roleResourceRelationTemplateRolePage, isRolePage);
		}
		else {
			roleResourceSearchObj.include = roleResourceRelationTemplateRolePage;
		}
		
		return roleResourceSearchObj;
	};

	/*Build serarch qry for Userresource table (with permissiongroup, pgresource,resource)  */
	const getUserResourceRelationObj = ( userid,permissiontype,isRolePage ) => {
		const roleResourceSearchObj = JSON.parse(JSON.stringify(userResourceSearchTemplate));

		roleResourceSearchObj.where.and.push({userid: userid}); 
		const roleResourceRelationTemplateRolePage = getRoleResourceRelationTemplate(roleResourceRelationTemplate, isRolePage, null, null);
		
		if (permissiontype == PermissionType.PermissionGroup) {
			roleResourceSearchObj.include = getRolePermissionGroupRelationTemplate(roleResourceRelationTemplateRolePage, isRolePage);
		}
		else {
			roleResourceSearchObj.include = roleResourceRelationTemplateRolePage;
		}
		
		return roleResourceSearchObj;
	};
	const extractResourcesFromRoleResource = roleResources => {
		return roleResources.map(rr => {
			const roleresource = JSON.parse(JSON.stringify(rr));
			const resource = roleresource.resource;
			if(resource) {
				resource.isallowed = roleresource.isallowed;
				resource.isvisible = roleresource.isvisible;
				resource.isenabled = roleresource.isenabled;
			}
			return resource;
		})
		.filter(x => x!=null);
	};

	const extractResourcesFromPGRoleResource = rolePGResources => {
		return rolePGResources.map(rr => {
			const roleresource = JSON.parse(JSON.stringify(rr));
			const resources = [];
			if(roleresource.permissiongroup) {
				const pgresources = roleresource.permissiongroup.pgresource;
				if(pgresources && pgresources.length > 0) {
					resources.push(filterpgresources(pgresources));
				}
			}

			return resources;
		})
		.filter(x => x!=null)
		.reduce((a, b) => a.concat(b), [])
		.reduce((a, b) => a.concat(b), []);
	};

	function filterpgresources(pgresources){
		return pgresources.map(pgresource => {
			const resource =  pgresource.resource;
			if(resource) {
				resource.isallowed = pgresource.isallowed;
				resource.isvisible = pgresource.isvisible;
				resource.isenabled = pgresource.isenabled;
			if(resource.resourcetype === 3 &&  pgresource.isenabled === true){
				resource.isallowed = false;
				resource.isvisible = false;
			}
				
			}
			return resource;
		})
		.filter(x => x!=null)
	}

	Authorize.getRoleProfile = data => {
		return Authorize.getProfile(data, RoleOrPage.Role);
	};

	const removeDuplicates = data => {
		let inputArray = [];
		data.map(element => {
			if(element.parentid != null && inputArray.indexOf(element.parentid) == -1) {
				inputArray.push(element.parentid);
			}
		})	
		return inputArray;
	}

	Authorize.getPageProfile = data => {
		let parentKey = '';
		let moduleKey = '';
		if(data && data.where) {
			parentKey = data.where.parentkey;
			moduleKey = data.where.modulekey;
			data.userid = data.where.userid;
		}
		return Authorize.getProfile(data, RoleOrPage.Page, parentKey, moduleKey);
	};

	Authorize.getProfile = (data, isRolePage, parentKey, moduleKey) => {
		let gRole = {};
		let gRoleResources = [];
		let gResources = []; 
		let gPermissiongorup=[] 
		const userid = data.userid ;
		return Authorize.findRole(userid)
		.then(extractRoleFromRM)
		.then(role => {
			gRole = role;
			return app.models.Roleresource.find(getRoleResourceRelationObj(gRole.id, PermissionType.Resource, isRolePage, parentKey, moduleKey));
		}).then(roleresources => {
			gRoleResources = JSON.parse(JSON.stringify(roleresources));
			return app.models.Roleresource.find(getRoleResourceRelationObj(gRole.id, PermissionType.PermissionGroup, isRolePage, parentKey, moduleKey));
		})
		.then(rolePGresources => {  
			gPermissiongorup =JSON.parse(JSON.stringify(rolePGresources)); /*Role table permission groups*/
			return app.models.Userresource.find(getUserResourceRelationObj( userid,PermissionType.PermissionGroup, isRolePage ));
 
		}).then (rolePGresourcesResult=>{
			const roleResources = extractResourcesFromRoleResource(gRoleResources); 
			const rolePGresourcesObj =  gPermissiongorup.concat(JSON.parse(JSON.stringify(rolePGresourcesResult)));/*Concat Userresource table permission groups*/
			const rolePGResources = extractResourcesFromPGRoleResource(rolePGresourcesObj);
			const concatresources = roleResources.concat(rolePGResources); 
			const parentids = removeDuplicates(concatresources);
		
			 return	Promise.resolve(app.models.Resource.find({
				fields: ['id', 'parentid', 'name', 'resourcetype', 'resourceid', 'modulekey','description','parentkey'],
				nolimit:true,
				where:  
				{activeflag: 1, id:{inq : parentids}} 
				 }).then(res => {
					res.map(x => {
						x.isallowed= true;
						x.isvisible=true;
						x.isenabled =true;
					  });
					  return res;
				 } )).then (x=>{ 	
				let resources = concatresources.concat(x); 

				resources = resources.sort((a, b) => a.id > b.id);
				if (resources.length > 0)
					{resources = resources.reduce(reducerFn, [resources[0]]);}
					
				gResources = resources;

				if(isRolePage == RoleOrPage.Page) {
					return app.models.Resource.find({
						nolimit:true,
						where: {or: [{resourceid: parentKey}, {resourceid:moduleKey}]},
						fields: ['id', 'name', 'resourceid', 'resourcetype', 'parentid', 'modulekey','description','parentkey']
					});
				}
				else {
					return Promise.resolve([]);
				}
			})  
		})
		.then(res => {
			let parentmoduleResources = JSON.parse(JSON.stringify(res));
			let resources = gResources;
			const returnObj = {
				role: gRole,
				resources: resources
			};

			if (parentmoduleResources.length > 0) {
				parentmoduleResources = filterparentmoduleResources(parentmoduleResources, gResources)
				resources = resources.filter(x => x.resourceid != parentKey && x.resourceid != moduleKey);
				const parentResource = parentmoduleResources && parentmoduleResources.length ? parentmoduleResources.filter(x => x.resourceid == parentKey ||  x.resourceid == moduleKey) : null;
				returnObj.resources = resources;
				returnObj.parentresource = parentResource;
			}
			return returnObj;
		})
		.catch(err => err);
	};

	function filterparentmoduleResources(parentmoduleResources, gResources){
		return parentmoduleResources.forEach(x => {
			x.isSelected = false;
			gResources.map(y => {
				if (y) {
					if (x.id === y.id) {
						Object.assign(x, y);
						x.isSelected = true;
					}
				}
			});
		});
	}
	const reducerFn = (prev, cur, index, array) => {
        // This is the value that we'll return at the end of each reduce iteration
        let toReturn;
        
        // Get a reference to the last item in the PREV array
        const lastObj = prev[prev.length - 1];
      
        // if the IDs are different, concat the cur obj into the prev array
        if(lastObj.id !== cur.id) {
          toReturn = prev.concat(cur);
        } 

        // // if the IDS are different, compare the isvisible & isenabled properties
        // if properties values different (true and false) make them true and return
        
		else if(lastObj.isvisible !== cur.isvisible) {
			cur.isvisible = true;
			prev.splice((prev.length - 1), 1, cur);
			toReturn = prev;
		}

		else if(lastObj.isenabled !== cur.isenabled) {
			cur.isenabled = true;
			prev.splice((prev.length - 1), 1, cur);
			toReturn = prev;
		}

        // otherwise just return the previous value
        else {
         toReturn = prev;
        }

        return toReturn;
      };

	Authorize.getPageProfile1 = data => {
		const userid = data.userid;
		const resourcesids = data.resources? data.resources : [];
		return Authorize.findRole(userid)
		.then(extractRoleFromRM)
		.then(role => Promise.all(resourcesids.map(resourceid => app.models.Roleresource.find({
			fields: ['resourceid', 'isvisible', 'isenabled'],
			nolimit:true,
			where: {and: [{roleid: role.id}, 
				{or: [{isvisible: true}, {isenabled: true}]}
			]},
			include: {
				relation: 'resource',
				scope: {
					where: {'parentid': resourceid},
					nolimit:true,
					fields: ['id', 'name', 'resourcetype', 'modulekey','description']
				}
			}
		}))))
		.then(resources => [].concat.apply([], resources)
			.map(rr => {
				const roleresource = JSON.parse(JSON.stringify(rr));
				if(roleresource.resource) {
					roleresource.resource.isvisible = roleresource.isvisible;
					roleresource.resource.isenabled = roleresource.isenabled;
				}
				return roleresource.resource;
			}).filter(x => x)
		)
		.catch(err => err);
	};

	
	Authorize.remoteMethod('getRoleProfile', {
		http: {
			path: '/getRoleProfile',
			verb: 'post'
		},
		accepts : [ {
			arg: 'filter',
			type: 'Object',
			required: false,
			http: {source: 'query'}
		} ],
		returns: {
			type : 'Object',
			root : true
		}
	});


	Authorize.remoteMethod('getPageProfile', {
		http: {
			path: '/getPageProfile',
			verb: 'get'
		},
		accepts : [ {
			arg: 'arg',
			type: 'Object',
			required: false,
			http: {source: 'query'}
		} ],
		returns: {
			type : 'Object',
			root : true
		}
	});

	Authorize.remoteMethod('getuserroles', {
		http: {
			path: '/getuserroles',
			verb: 'get'
		},
		accepts : [ {
			arg: 'filter',
			type: 'Object',
			required: false,
			http: {source: 'query'}
		}, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		returns: {
			type : 'Object',
			root : true
		}
	});

	Authorize.getuserroles = (request, reqctx) => {  
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
		const userid = (request && request.securityuserid?request.securityuserid: _securityusersid);
		let path = null;
		if(request && request.where) {
			path = request.where.path;
		}
		let sql = 'select * from getuserroles($1,$2)';        
		return util.executeSecondaryNodeDBQuery(sql, [userid,path])
		.then(data => { return data; })
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
	};

	Authorize.remoteMethod('getCJAMSRoleMasterList', {
		http: { path: '/getCJAMSRoleMasterList', verb: 'post' },
		accepts: [
			{ arg: 'data', type: 'object', required: true, http: { source: 'body' } },
			{ arg: 'reqctx', type: 'object', http: { source: 'context' } }
		],
		returns: { type: 'Array', root: true }
	});
	
	Authorize.getCJAMSRoleMasterList = function (data, reqctx) {
		const _usecurityusersid = util.getSecurityDetails(data, reqctx).u_securityuserid;
	
		const agency = data.agency || null;
	
		const externalapidata = {
			details: {
				objectid: 'getCJAMSRoleMasterList',
				objecttype: 'getCJAMSRoleMasterList',
				updatedby: _usecurityusersid,
				insertedby: _usecurityusersid
			},
			resstatus: '',
			request: data,
			response: null,
			status: 'add'
		};
	
		let v_externalapilogsid = null;

		return commonapi.addupdateexternalapilogs(externalapidata).then(logid => {
			v_externalapilogsid = logid;

			const sql = `SELECT * FROM cjams.getcjamsrolemasterlist($1);`;
			const params = [agency];

			return util.executeDBQuery(sql, params).then(result => {
				const successLog = {
					details: {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'getCJAMSRoleMasterList',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					},
					info: null,
					status: 'fetch',
					resstatus: 'success',
					response: result
				};

				commonapi.addupdateexternalapilogs(successLog);
				return result;
			}).catch(err => {
				LOGGER.error('<< getCJAMSRoleMasterList logs >>', err);

				const errorLog = {
					details: {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'getCJAMSRoleMasterList',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					},
					info: null,
					status: 'fetch',
					resstatus: 'error',
					response: err
				};

				commonapi.addupdateexternalapilogs(errorLog);
				throw err;
			});
		}).catch(err => {
			LOGGER.error('<< getCJAMSRoleMasterList logs >>', err);
			throw err;
		});
	};

	

	Authorize.remoteMethod('getuserdetailsbyemail', {
        http: { path: '/getuserdetailsbyemail', verb: 'post' },
        accepts: [
            { arg: 'data', type: 'object', required: true, http: { source: 'body' } },
            { arg: 'reqctx', type: 'object', http: { source: 'context' } }
        ],
        returns: { type: 'Object', root: true }
    });

    Authorize.getuserdetailsbyemail = function (data, reqctx) {
        const _usecurityusersid = util.getSecurityDetails(data, reqctx).u_securityuserid;
        const email = data.v_email;

		const externalapidata = {};
        externalapidata.details =  {
            objectid: email,
            objecttype: 'getuserdetailsbyemail',
            updatedby: _usecurityusersid,
            insertedby: _usecurityusersid
        }
        externalapidata.resstatus = '';
        externalapidata.request = data;
        externalapidata.response = null;
        externalapidata.status = 'add';

        let v_externalapilogsid = null;

        if (!email) {
			LOGGER.error("Email is required - getuserdetailsbyemail called without an email");
            throw new Error("Email is required");
        }

        return commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
            v_externalapilogsid = data1;

            let sql = `SELECT * FROM cjams.getuserdetailsbyemail($1)`;

            return util.executeDBQuery(sql, [email]).then(data_v => {
                const externalapidata2 = {
                    details: {
                        externalapilogsid: v_externalapilogsid,
                        objecttype: 'getuserdetailsbyemail',
                        updatedby: _usecurityusersid,
                        insertedby: _usecurityusersid
                    },
                    info: null,
                    status: 'fetch',
                    response: data_v.length > 0 ? data_v[0] : null,
                    resstatus: data_v.length > 0 ? 'success' : 'error'
                };

                commonapi.addupdateexternalapilogs(externalapidata2);
                return externalapidata2.response;
            }).catch(err => {
                LOGGER.error('<< getuserdetailsbyemail logs >>', err);

                const externalapidata1 = {
                    details: {
                        externalapilogsid: v_externalapilogsid,
                        objecttype: 'getuserdetailsbyemail',
                        updatedby: _usecurityusersid,
                        insertedby: _usecurityusersid
                    },
                    info: null,
                    status: 'fetch',
                    resstatus: 'error',
                    response: err
                };

                commonapi.addupdateexternalapilogs(externalapidata1);
                throw err;
            });
        });
    };


	Authorize.remoteMethod('getallusersdetails', {
        http: { path: '/getallusersdetails', verb: 'post' },
        accepts: [
            { arg: 'data', type: 'object', required: true, http: { source: 'body' } },
            { arg: 'reqctx', type: 'object', http: { source: 'context' } }
        ],
        returns: { type: 'Array', root: true }
    });


    Authorize.getallusersdetails = function (data, reqctx) {
        const _usecurityusersid = util.getSecurityDetails(data, reqctx).u_securityuserid;
        const limit = data.limit || 100; 
        const offset = data.offset || 0;
		const externalapidata = {}; 
        externalapidata.details =  {
            objectid: 'getallusersdetails',
            objecttype: 'getallusersdetails',
            updatedby: _usecurityusersid,
            insertedby: _usecurityusersid
        }
        externalapidata.resstatus = '';
        externalapidata.request = data;
        externalapidata.response = null;
        externalapidata.status = 'add';

        let v_externalapilogsid = null;

        return commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
            v_externalapilogsid = data1;

            let sql = `SELECT * FROM cjams.getallusersdetails($1, $2)`;

            return util.executeDBQuery(sql, [limit, offset]).then(data_v => {
                const externalapidata2 = {
                    details: {
                        externalapilogsid: v_externalapilogsid,
                        objecttype: 'getallusersdetails',
                        updatedby: _usecurityusersid,
                        insertedby: _usecurityusersid
                    },
                    info: null,
                    status: 'fetch',
                    response: data_v,
                    resstatus: 'success'
                };

                commonapi.addupdateexternalapilogs(externalapidata2);
                return data_v;
            }).catch(err => {
                LOGGER.error('<< getallusersdetails logs >>', err);

                const externalapidata1 = {
                    details: {
                        externalapilogsid: v_externalapilogsid,
                        objecttype: 'getallusersdetails',
                        updatedby: _usecurityusersid,
                        insertedby: _usecurityusersid
                    },
                    info: null,
                    status: 'fetch',
                    resstatus: 'error',
                    response: err
                };

                commonapi.addupdateexternalapilogs(externalapidata1);
                throw err;
            });
        });
    };

	Authorize.useronboarding = function(data, reqctx) {
        const _usecurityusersid = util.getSecurityDetails(data, reqctx).u_securityuserid;
        const externalapidata = {}; 
        externalapidata.details =  {
            objectid: data.v_email,
            objecttype: 'useronboarding',
            updatedby: _usecurityusersid,
            insertedby: _usecurityusersid
        }
        externalapidata.resstatus = '';
        externalapidata.request = data;
        externalapidata.response = null;
        externalapidata.status = 'add';
        let v_externalapilogsid = null;
        return commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
            v_externalapilogsid = data1;
			let sql = "select * from cjams.useronboarding($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23)";
			return util.executeDBQuery(sql, [data.v_email,data.v_firstname,data.v_lastname,data.v_middlename,data.v_fullname,data.v_agencycode,data.v_openamrole,
				data.v_countycode,data.v_teamcode,data.v_teamname,data.v_ldss,data.v_add1,data.v_city,data.v_zipcode,data.v_cell_phonenumber,data.v_staffid,
				data.v_positioncode,data.v_positiontitle,data.v_username,data.v_super_id,data.v_as_super_id,data.v_isaddorremove,data.v_work_phonenumber])
				.then(data_v => {
					const externalapidata2 = {};
					externalapidata2.details = {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'useronboarding',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					}
					const resp = data_v && data_v.length > 0 ? data_v[0].useronboarding: null;
					externalapidata2.info = null;
					externalapidata2.status = 'update';
					externalapidata2.response = resp;
					externalapidata2.resstatus = resp && resp.includes('Error Code') ? 'error': 'success';
					commonapi.addupdateexternalapilogs(externalapidata2);
					return resp;
				})
				.catch(err => {
					LOGGER.error('<< useronboarding logs >>',err)
					const externalapidata1 = {};
					externalapidata1.details = {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'useronboarding',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					}

					externalapidata1.info = null;
					externalapidata1.status = 'update';
					externalapidata1.resstatus = 'error';
					externalapidata1.response = err;
					commonapi.addupdateexternalapilogs(externalapidata1);
					throw err;
				});
        });
    };

	Authorize.updateUserProfileDetails = function (data, reqctx) {
		const _usecurityusersid = util.getSecurityDetails(data, reqctx).u_securityuserid;
		const externalapidata = {}; 
        externalapidata.details =  {
            objectid: data.v_email,
            objecttype: 'updateUserProfileDetails',
            updatedby: _usecurityusersid,
            insertedby: _usecurityusersid
        }
        externalapidata.resstatus = '';
        externalapidata.request = data;
        externalapidata.response = null;
        externalapidata.status = 'add';
	
		let v_externalapilogsid = null;

		return commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
			v_externalapilogsid = data1;

			let sql = `
				SELECT * FROM cjams.updateUserProfileDetails(
					$1, $2, $3, $4, $5, $6, $7, $8, $9, $10,
					$11, $12, $13, $14
				)
			`;

			return util.executeDBQuery(sql, [
				data.v_email,
				data.v_agencycode,
				data.v_countycode,
				data.v_teamcode,
				data.v_teamname,
				data.v_ldss,
				data.v_add1,
				data.v_city,
				data.v_zipcode,
				data.v_cell_phonenumber,
				data.v_positioncode,
				data.v_super_id,
				data.v_as_super_id,
				data.v_work_phonenumber
			]).then(data_v => {
				const externalapidata2 = {
					details: {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'updateUserProfileDetails',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					},
					info: null,
					status: 'update',
					response: data_v && data_v.length > 0 ? data_v[0].updateuserprofiledetails : null,
					resstatus: data_v && data_v.length > 0 && data_v[0].updateuserprofiledetails.includes('Error Code') ? 'error' : 'success'
				};
				commonapi.addupdateexternalapilogs(externalapidata2);
				return externalapidata2.response;
			}).catch(err => {
				LOGGER.error('<< updateUserProfileDetails logs >>',err)
				const externalapidata1 = {
					details: {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'updateUserProfileDetails',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					},
					info: null,
					status: 'update',
					resstatus: 'error',
					response: err
				};
				commonapi.addupdateexternalapilogs(externalapidata1);
				throw err;
			});
		}).catch(err => LOGGER.error('<< updateUserProfileDetails logs >>',err));
	};
	
	
	Authorize.remoteMethod('updateUserProfileDetails', {
		http: {
			path: '/updateUserProfileDetails',
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
	
	Authorize.addupdateUserRoles = function (data,reqctx) {
		const _usecurityusersid = util.getSecurityDetails(data,reqctx).u_securityuserid;

		const externalapidata = {
			details: {
				objectid: data.v_email,
				objecttype: 'addupdateUserRoles',
				updatedby: _usecurityusersid,
				insertedby: _usecurityusersid
			},
			resstatus: '',
			request: data,
			response: null,
			status: 'add'
		};
		let v_externalapilogsid = null;
		return commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
			v_externalapilogsid = data1;
			const sql = `SELECT * FROM cjams.addupdateUserRoles($1, $2, $3, $4)`;
			const params = [
				data.v_email,
				data.v_agencycode,
				data.addRoles || [],
				data.removeRoles || []
			];
			return util.executeDBQuery(sql,params).then((data_v) => {
				const responseMessage = data_v && data_v.length > 0 ? data_v[0].addupdateuserroles : null;

				const externalapidata2 = {
					details: {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'addupdateUserRoles ',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					},
					info: null,
					status: 'update',
					response: responseMessage,
					resstatus: responseMessage && responseMessage.includes('Error') ? 'error' : 'success'
				};
				commonapi.addupdateexternalapilogs(externalapidata2);
				return responseMessage;
			}).catch((err) => {
				LOGGER.error('<< addupdateUserRoles  logs >>',err);
				const externalapidata1 = {
					details: {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'addupdateUserRoles',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					},
					info: null,
					status: 'update',
					resstatus: 'error',
					response: err
				};
				commonapi.addupdateexternalapilogs(externalapidata1);
				throw err;
			});
		}).catch(err => {
			LOGGER.error('<< addupdateUserRoles  logs >>',err);
			throw err;
		});
	};
	
	Authorize.remoteMethod('addupdateUserRoles', {
		http: {
			path: '/addupdateUserRoles',
			verb: 'post'
		},
		accepts: [
			{ arg: 'data', type: 'object', http: { source: 'body' } },
			{ arg: 'reqctx', type: 'object', http: { source: 'context' } }
		],
		returns: {
			type: 'object',
			root: true
		}
	});
	
    Authorize.remoteMethod('useronboarding', {
        http: {
                path: '/useronboarding',
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

	Authorize.useroffboarding = function(data, reqctx) {
        const _usecurityusersid = util.getSecurityDetails(data, reqctx).u_securityuserid;
        const externalapidata = {}; 
        externalapidata.details =  {
            objectid: data.v_email,
            objecttype: 'useroffboarding',
            updatedby: _usecurityusersid,
            insertedby: _usecurityusersid
        }
        externalapidata.resstatus = '';
        externalapidata.request = data;
        externalapidata.response = null;
        externalapidata.status = 'add';
        let v_externalapilogsid = null;
        return commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
            v_externalapilogsid = data1;
			let sql = "select * from cjams.useroffboarding($1)";
			return util.executeDBQuery(sql, [data.v_email])
				.then(data_v => {
					const externalapidata2 = {};
					externalapidata2.details = {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'useroffboarding',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					}
					const resp = data_v && data_v.length > 0 ? data_v[0].useroffboarding: null;
					externalapidata2.info = null;
					externalapidata2.status = 'update';
					externalapidata2.response = resp;
					externalapidata2.resstatus = resp && resp.includes('Error Code') ? 'error': 'success';
					commonapi.addupdateexternalapilogs(externalapidata2);
					return resp;
				})
				.catch(err => {
					LOGGER.error('<< useroffboarding >>',err)
					const externalapidata1 = {};
					externalapidata1.details = {
						externalapilogsid: v_externalapilogsid,
						objecttype: 'useroffboarding',
						updatedby: _usecurityusersid,
						insertedby: _usecurityusersid
					}

					externalapidata1.info = null;
					externalapidata1.status = 'update';
					externalapidata1.resstatus = 'error';
					externalapidata1.response = err;
					commonapi.addupdateexternalapilogs(externalapidata1);
					throw err;
				});
        });
    };

    Authorize.remoteMethod('useroffboarding', {
        http: {
                path: '/useroffboarding',
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

    Authorize.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Authorize.observe('access', (ctx, next) => util.access(ctx, next));
    Authorize.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next)); 
};
