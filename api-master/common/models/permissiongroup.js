'use strict';
const LOGGER = require("log4js").getLogger("permissiongroup");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Permissiongroup) {


    const makeTree = (resource, origResource) => {

        resource.children = origResource.filter(x => x.parentid === resource.resourceid);
        resource.children.forEach(x => makeTree(x, origResource));
    };


    Permissiongroup.addupdate =(request, reqctx)=>{
        let _securityusersid = undefined;
		if(reqctx?.req?.headers?.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        const securityuserid = request.securityuserid  ? request.securityuserid  : _securityusersid;
        const rearray = [];
        var resorceidarray = request.resource;
       let permission = {};
       var resourcearray = Array.isArray(request.resource) ? request.resource : [];
        if(request.permissiongroupid !==undefined){
                var activeflag = 1;
                return Permissiongroup.upsert({
                    permissiongroupid:request.permissiongroupid,
                    description:request.description,
                    permissiongroupname:request.permissiongroupname,
                    activeflag:activeflag
                }).then(data =>{
                        rearray.push(resorceidarray.filter(x =>x.pgresourceid)
                        .map(pgresid =>{
                            var sql = 'UPDATE pgresource SET activeflag=$1,isenabled=$2, isallowed=$3,isvisible =$4 where pgresourceid = $5';
                            var _activeflag = 1;
                            var isallowed = pgresid.isallowed;
                            var isenabled = pgresid.isenabled;
                            var isvisible = pgresid.isvisible;
                            return util.executeDBQuery(sql, [_activeflag,isenabled,isallowed,isvisible,pgresid.pgresourceid]);
                        }));

                        resorceidarray.filter(x => !x.pgresourceid).forEach(x => x.permissiongroupid = request.permissiongroupid);
                        rearray.push(
                            resorceidarray.filter(x => !x.pgresourceid)
                            .map(pgresid => {
                                return app.models.Pgresource.create(pgresid);
                            })
                        );

                        return Promise.all(rearray);    //sonarqube -removed the non-reachable code after the return statement
                    })
                    .then(res => "Updated Successfully")
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });


                } else{
             return Permissiongroup.find({where:
                {permissiongroupname:request.permissiongroupname}
            }).then(res => {
                if(res.length > 0){
                    return "Already Exist"
                }else if(res.length === 0){
                    return Permissiongroup.create({
                        description:request.description,
                        permissiongroupname:request.permissiongroupname,
                        insertedby: securityuserid,
                        updatedby: securityuserid
                        }).then(response =>{
                                 permission = response;
                                    const permissiongroupid = response.permissiongroupid;
                                return Promise.all(resourcearray.map(element => {
                                    var  resource = element;
                                    var _activeflag = 1;
                                        return app.models.Pgresource.create({
                                            permissiongroupid:permissiongroupid,
                                            resourceid:resource.resourceid,
                                            activeflag:_activeflag,
                                            isallowed:resource.isallowed,
                                            isvisible:resource.isvisible,
                                            isenabled:resource.isenabled,
                                            insertedby: securityuserid,
                                            updatedby: securityuserid
                                            })
                                         })
                                 );
                                    }).then(data =>
                                        {
                                            const returndata = {};
                                            returndata.data = permission;
                                            returndata.resource = data;
                                            return returndata;
                                        })
                                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                                   }
                                })
							}
                        }




    Permissiongroup.deletepermission = (id) => {
        var result;
    return Permissiongroup.updateAll(
        {
        permissiongroupid:id
        },{activeflag:0}
    ).then(res => {
            result = res;
            return app.models.Pgresource.updateAll({
                permissiongroupid:id
            },{activeflag:0})
    }).then(data => {
        const returndata = {};
        returndata.permissiongroup = result;
        returndata.resource = data;
        return returndata;
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    }

    Permissiongroup.flatresourcelist = arg => {

        let resourcetype = [1];
        let permissiongroupid = '';
        let resources;
        let modulekey = '';

        if (arg?.where) {
            resourcetype = arg.where.resourcetype;
            modulekey = arg.where.modulekey;
            permissiongroupid = arg.where.permissiongroupid;
        }
        let resourcewhere = {resourcetype: {inq:resourcetype}};

        if(modulekey && modulekey !== '')
        {
            resourcewhere = {resourcetype: {inq:resourcetype}, modulekey: modulekey};
        }

        return app.models.Resource.find({
            where: resourcewhere,
            nolimit:arg.nolimit,
            fields: ['id', 'name', 'resourceid', 'resourcetype'],
            order: 'name asc'
        })
        .then(res => {
            resources = JSON.parse(JSON.stringify(res));

            if(!permissiongroupid || permissiongroupid === ''){
                permissiongroupid = null;
                return resources;
            }
            return app.models.Pgresource.find({
                where: {permissiongroupid: permissiongroupid},
                nolimit:arg.nolimit,
                fields: ['pgresourceid', 'permissiongroupid', 'resourceid', 'isallowed', 'isvisible', 'isenabled'],
                include: {
                    relation: 'resource',
                    scope: {
                        where: resourcewhere,
                        nolimit:arg.nolimit,
                        fields: ['id', 'name', 'resourceid', 'resourcetype'],
                        order: 'name asc'
                    }
                }
            })
        })
        .then(res => {
            if(permissiongroupid == null){
                return resources;
            }
            const data = JSON.parse(JSON.stringify(res));
            const pgresources = data.map(x => {
                if (x.resource) {
                    x.resource.pgresourceid = x.pgresourceid;
                    x.resource.isallowed = x.isallowed;
                    x.resource.isvisible = x.isvisible;
                    x.resource.isenabled = x.isenabled;
                }

                return x.resource;
            }).reduce((a,b) => a.concat(b), []);
            resources.forEach(x => {
                x.isSelected = false;
                pgresources.map(y => {
                    if (x?.id === y?.id) {
                            Object.assign(x, y);
                            x.isSelected = true;
                    }
                })
            })
            return resources;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Permissiongroup.listresource = (arg) =>{
        const sql = 'select * from getresources($1, $2, $3)';
        const params = [arg.limit,arg.page,arg.permissiongroupid];

        return util.executeDBQuery(sql, params).then(resource => {
            let result = JSON.parse(JSON.stringify(resource));
            result
                .filter(x => x.parentid === null)
                .forEach(x => makeTree(x, result));

           result = result.filter(x => x.parentid === null);
            return result;

        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });


    }

    Permissiongroup.listroleresource = (arg) =>{
        const sql = 'select * from getpgresources($1, $2, $3)';
        const params = [arg.limit,arg.page,arg.roleid];

        return util.executeDBQuery(sql, params).then(_resource => {
            let result = JSON.parse(JSON.stringify(_resource));
            result
                .filter(x => x.parentid === null)
                .forEach(x => makeTree(x, result));
                  result = result.filter(x => x.parentid === null);
              return result;

        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });


    }
// Roleresource - permissiongroup -- permissiongroupid
    Permissiongroup.listrole =(arg) =>{
             const _permissiontype1 = 1;
             var reslt;
         return app.models.Roleresource.find({where:{and:[{roleid:arg.where.roleid},{permissiontype:_permissiontype1}]},
        fields:[ 'resourceid'],
              include:{
                  relation: 'permissiongroup',
                  where:{activeflag:true},
                  scope:{
                      fields:['permissiongroupname','permissiongroupid']
                  }
              }
        }).then(data => {
            reslt = data;
        const sql = 'select * from getpgresources($1, $2, $3)';
        const params = [arg.limit,arg.page,arg.where.roleid];

        return util.executeDBQuery(sql, params);
       }).then(resp => {
            let result = JSON.parse(JSON.stringify(resp));
            result
                .filter(x => x.parentid === null)
                .forEach(x => makeTree(x, result));

           result = result.filter(x => x.parentid === null);
            return result;

        }).then(res =>{
            return {
                permissiongroup : reslt,
                resource : res
            };
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

Permissiongroup.list = data => {
  const emptyUUID = '00000000-0000-0000-0000-000000000000';

  let roleid = data.where.roleid;
  if(!roleid) {
    roleid = emptyUUID;
  }

  let gResources;
  const bnolimit= data.nolimit?data.nolimit:false;
  return Permissiongroup.find({
      fields: ['permissiongroupid','permissiongroupname','description'],
      where: {activeflag: true},
      nolimit:bnolimit,
      order: 'permissiongroupname asc'
  })
  .then(data2 => {
      gResources = JSON.parse(JSON.stringify(data2));
      return app.models.Roleresource.find({
          fields: ['roleid','permissiontype','resourceid'],
          where:{and : [{permissiontype: 1}, {roleid: roleid }]},
          nolimit:bnolimit,
      })
  })
  .then(data3 => {
      const pgresources = JSON.parse(JSON.stringify(data3));
      return gResources.map(resource => {
          if (pgresources.map(x => x.resourceid).indexOf(resource.permissiongroupid) > -1){
              resource.isSelected = true;
          }else{
              resource.isSelected = false;}
          return resource;
      });
  })
  .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};


Permissiongroup.remoteMethod('list', {
  http: {
    path: '/list',
    verb: 'get'
  },
  accepts : [ {
    arg: 'filter',
    type: 'Object',
    required: true,
    http: {source: 'query'}
  } ],
  returns: {
    type : 'Object',
    root : true
  }
});


    Permissiongroup.remoteMethod('listrole', {
        accepts:
            {
                arg: 'filter',
                type: 'object',
                http : {
                    source : 'query'
                },
                required : true
            },
        http: { "verb": "get", "path": "/listrole" },
        returns: {
            type: 'Object',
            root: true
        }
    });


    Permissiongroup.remoteMethod('listroleresource', {
        accepts : {
            arg: 'arg',
            type: 'Object',
            http: {source: 'query'}
        },
        http: {"verb": "get", "path": "/listroleresource"},
        returns : {
			type : 'Object',
			root : true
		}
    });

    Permissiongroup.remoteMethod('listresource', {
        accepts : {
            arg: 'arg',
            type: 'Object',
            http: {source: 'query'}
        },
        http: {"verb": "get", "path": "/listresource"},
        returns : {
			type : 'Object',
			root : true
		}
    });

    Permissiongroup.remoteMethod('flatresourcelist', {
        accepts : {
            arg: 'arg',
            type: 'Object',
            http: {source: 'query'}
        },
        http: {"verb": "get", "path": "/flatresourcelist"},
        returns : {
			type : 'Object',
			root : true
		}
    });

    Permissiongroup.remoteMethod('deletepermission', {
        accepts:
            {
                arg: 'id',
                type: 'string',
                required: true,
                http: { source: 'path' }
            },
        http: { "verb": "delete", "path": "/deletepermission/:id" },
        returns: {
            type: 'Object',
            root: true
        }
    });


    Permissiongroup.remoteMethod(
        'addupdate',
                {
                  http: {
                          path: '/addupdate',
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
                      type : 'object',
                        root : true
                  }
                 }
    );

	Permissiongroup.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Permissiongroup.observe('access', (ctx, next) => util.access(ctx, next));
	Permissiongroup.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}

