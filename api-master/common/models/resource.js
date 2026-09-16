'use strict';
const LOGGER = require("log4js").getLogger("resource");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Resource) {

    Resource.list = data => {
        const emptyUUID = '00000000-0000-0000-0000-000000000000';
        const emptyID = 0;

        let permissiongroupid = data.where.permissiongroupid;
        let roleid = data.where.roleid;
        if(!permissiongroupid){
            permissiongroupid = emptyUUID;
        }
        if(!roleid){
            roleid = emptyID;
        }
        const parentid = data.where.parentid;
        const resourcetype = data.where.resourcetype;

        let gResources;
        let pgresources;


        return Resource.find({
            fields: ['id', 'parentid', 'name', 'resourceid', 'resourcetype'],
            where: {and: [{resourcetype:{inq: resourcetype}},{parentid:parentid}]}

        })
        .then(data1 => {
            gResources = JSON.parse(JSON.stringify(data1));
            return app.models.Pgresource.find({
                fields: ['pgresourceid','resourceid','isallowed','isvisible','isenabled'],
                where: {permissiongroupid: permissiongroupid},
                include: {
                    relation: 'resource',
                    scope: {
                        fields: ['resourceid'],
                        where: {resourcetype: {inq: resourcetype}}
                    }
                }
            })
        })
        .then(data2 => {
          pgresources = JSON.parse(JSON.stringify(data2));
          return app.models.Roleresource.find({
              fields: ['id','roleid','resourceid','isallowed','isvisible','isenabled'],
              where: {roleid: roleid},
              include: {
                  relation: 'resource',
                  scope: {
                      fields: ['resourceid'],
                      where: {resourcetype: {inq: resourcetype}}
                  }
              }
          })
      })
        .then(data3 => {
            const RoleResources = JSON.parse(JSON.stringify(data3));
            if(pgresources.length > 0)
            {
              return gResources.map(resource => {
              const  pgResourceIndex = pgresources.map(x => x.resourceid).indexOf(resource.id);

                if (pgResourceIndex > -1) {
                  resource.isallowed = pgresources[pgResourceIndex].isallowed;
                  resource.isvisible = pgresources[pgResourceIndex].isvisible;
                  resource.isenabled = pgresources[pgResourceIndex].isenabled;
                  resource.pgresourceid = pgresources[pgResourceIndex].pgresourceid;
                }
                return resource;
            });
            } else {

              return gResources.map(resource => {
                const  roleResourceIndex = RoleResources.map(x => x.resourceid).indexOf(resource.id);
                if (roleResourceIndex > -1) {
                  resource.isallowed = RoleResources[roleResourceIndex].isallowed;
                  resource.isvisible = RoleResources[roleResourceIndex].isvisible;
                  resource.isenabled = RoleResources[roleResourceIndex].isenabled;
                  resource.roleresourceid = RoleResources[roleResourceIndex].id;
                }
                return resource;
            });
            }

        })
        .catch(err => util.logError(err));
    };

    Resource.flatlist = arg => {
        let resourcetype = 1;

        if (arg && arg.where){
            resourcetype = arg.where.resourcetype;
        }
        return Resource.find({
            where: {resourcetype: resourcetype},
            fields: ['id', 'name', 'resourceid', 'resourcetype']
        })
        .then(data => data)
        .catch(err => util.logError(err));
    }

    Resource.remoteMethod('flatlist', {
        accepts : {
            arg: 'arg',
            type: 'Object',
            http: {source: 'query'}
        },
        http: {"verb": "get", "path": "/flatlist"},
        returns : {
			type : 'Object',
			root : true
		}
    });

    Resource.resourcelist = data => {


      const parentid = data.where.parentid;
      const resourcetype = data.where.resourcetype;

      let gResources;


      return Resource.find({
          fields: ['id', 'parentid', 'name', 'resourceid', 'resourcetype','tooltip'],
          where: {and: [{resourcetype:{inq: resourcetype}},{parentid:parentid}]}

      })
      .then(data1 => {
          gResources = JSON.parse(JSON.stringify(data1));
       return gResources;
        })
      .catch(err => util.logError(err));
  };


Resource.updatetooltip = (id, data) => {

  const resourceid = id;

      return app.models.Resource.updateAll({id: resourceid}, {tooltip: data.tooltip})
      .then(data1=>{
          LOGGER.debug(JSON.stringify("data:"+data1));
          return data1;
      })
      .catch(err=>err);
  };


    Resource.remoteMethod('list', {
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


  Resource.remoteMethod('resourcelist', {
		http: {
			path: '/resourcelist',
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


  Resource.remoteMethod('updatetooltip', {
    http: {
      path: '/updatetooltip/:id',
      verb: 'patch'
    },
    accepts: [
      {
        arg: 'id',
        type: 'data',
        required: true,
        http: { source: 'path' }
      },
      {
        arg: 'data',
        type: 'object',
        http: { source: 'body' }
      }],
    returns: {
      type: 'object',
      root: true
    }
  });

  Resource.remoteMethod('getresources', {
		http: {
			path: '/getresources',
			verb: 'get'
		},
		accepts : [ {
			arg: 'filter',
			type: 'Object',
			required: true,
			http: {source: 'query'}
		} ],
		returns: {
			type : 'Array',
			root : true
		}
  });

  Resource.getresourcesbymodule = request => {
    if (request.where.modulename == undefined) {request.where.modulename = null;}
    var pageno = request.page;
    var pagesize = request.limit;
    var totalcount = 0;
    var sql = 'select * from getresourcesbymodule($1,$2,$3)';
    return util.executeDBQuery(sql, [request.where.modulename, pageno, pagesize])
      .then(data => {
        if (data !== null && data.length > 0){
          totalcount = data[0].totalcount;}
        return {
          'data': data,
          'count': totalcount
        }
      })
      .catch(err => util.logError(err));
  };

  Resource.remoteMethod('getresourcesbymodule', {
    http: {
      path: '/getresourcesbymodule',
      verb: 'get'
    },
    accepts: [{
      arg: 'filter',
      type: 'Object',
      required: true,
      http: { source: 'query' }
    }],
    returns: {
      type: 'Array',
      root: true
    }
  });
  
  Resource.getresources = request => {
    if(request.where.id==undefined) {request.where.id=null;  }
    if(request.where.parentid==undefined) {request.where.parentid=null; }
    if(request.where.resourcetype==undefined) {request.where.resourcetype=null; }
    var pageno = request.page;
    var pagesize = request.limit;
    var totalcount=0;
    var sql = 'select * from getresourceslist($1,$2,$3,$4,$5)';
		return util.executeDBQuery(sql, [request.where.id,request.where.parentid,request.where.resourcetype,pageno,pagesize])
    .then(data1 => {
      if (data1!==null && data1.length>0){
        totalcount = data1[0].totalcount;}
      return {
        'data' : data1,
        'count' : totalcount
        }
    })
    .catch(err => util.logError(err));
};

Resource.remoteMethod('getresourcesbytype', {
  http: {
    path: '/getresourcesbytype',
    verb: 'get'
  },
  accepts : [ {
    arg: 'filter',
    type: 'Object',
    required: true,
    http: {source: 'query'}
  } ],
  returns: {
    type : 'Array',
    root : true
  }
});

Resource.getresourcesbytype = request => {
  var totalcount=0;
  // prettier-ignore
  var sql = `SELECT COUNT(1) OVER(),rs.id,rs.parentid,rs.resourcename as name,rs.resourcetype,rs.resourceid,rs.tooltip,rs.description,rs.parentkey,rs.modulekey,rt.description
              FROM resource rs INNER JOIN referencevalues rt ON rt.ref_key = rs.resourcetype ::character varying AND rt.referencetypeid = 344 AND rt.activeflag=1 WHERE rs.activeflag = 1 and
              rs.resourcetype = any ($1)`;
  return util.executeDBQuery(sql, [request.where.resourcetype])
  .then(data2 => {
    if (data2!==null && data2.length>0){
      totalcount = data2[0].totalcount;}
    return {
      'data' : data2,
      'count' : totalcount
      }
  })
  .catch(err => util.logError(err));
};

    Resource.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Resource.observe('access', (ctx, next) => util.access(ctx, next));
    Resource.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
