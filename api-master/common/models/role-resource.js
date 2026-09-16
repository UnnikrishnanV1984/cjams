'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Roleresource) {

	Roleresource.roleaddupdate =(request, reqctx )=>{
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        const rolerearray = [];
        var resorceidarray = request.roleresource;
       let role = {};
        if(request.id !==undefined){
                var sql = 'UPDATE role_resource SET activeflag = 0 where roleid =$1 and permissiontype = 1';
                return util.executeDBQuery(sql, [request.id])
                .then(reslt => {
                    return reslt;
                })
                //})    
                .then(data =>{
                    rolerearray.push(resorceidarray.filter(x =>x.id)
                        .map(pgresid =>{
                            var sql1 = 'UPDATE role_resource SET activeflag=1,isenabled=$1, isallowed=$2,isvisible =$3,permissiontype =$4 where id =$5 and permissiontype = 1';
                            
                            var isallowed = pgresid.isallowed;
                            var isenabled = pgresid.isenabled;
                            var isvisible = pgresid.isvisible;
                            var permissiontype = pgresid.permissiontype;
                            return util.executeDBQuery(sql1, [isenabled,isallowed,isvisible,permissiontype,pgresid.id])
                            .then(data1 => {
                                return data1;
                            })
                            .catch(err => {
                                LOGGER.error(err)
                                return err;
                            })
                        }));

                        resorceidarray.filter(x => !x.id).forEach(x => x.roleid = request.id);
                        rolerearray.push(
                            resorceidarray.filter(x => !x.id)
                            .map(pgresid => {
                                return app.models.Roleresource.create(pgresid);
                            })
                        );

                        return Promise.all(rolerearray)
                    })
                    .then(res => "Updated Successfully")
                    .catch(err => {
                        LOGGER.error(err)
                        return err;
                    })
                     
                
                } else{
             return app.models.Role.find({where:
                {name:request.name}
            }).then(res => {
                if(res.length > 0){
                    return "Already Exist"
                }else if(res.length === 0){
                    return app.models.Role.create({
                        description:request.description,
                        name:request.name
                        }).then(res1 =>{
                                 role = res1;
                                    const roleid = res1.id;
                                    var rolerearray1 = request.roleresource;
                        if(Array.isArray(rolerearray1)){
                                return Promise.all(rolerearray1.map(element => {
                                    var  role1 = element;
                                    var activeflag1 = 1;
                                        return app.models.Roleresource.create({
                                            roleid:roleid,
                                            resourceid:role1.resourceid,
                                            activeflag:activeflag1,
                                            isallowed:role1.isallowed,
                                            isvisible:role1.isvisible,
                                            isenabled:role1.isenabled,
                                            permissiontype:role1.permissiontype,
                                            insertedby: _securityusersid,
                                            updatedby: _securityusersid
                                            })
                                         })
                                 );
                            }
                                    
                                    }).then(data => 
                                        {
                                            const returndata = {};
                                            returndata.data = role;
                                            returndata.roleresource = data;
                                            return returndata;
                                        })
                                    .catch (err => err);
                                   }     
                                })
							}
                        }

	Roleresource.Deleterole = (id) => {
			var roletypekey,newrole,newteammember;
              return app.models.Role.findOne({
               where :{
                   id:id
               }
              }).then(res =>{
                  roletypekey = res.roletypekey;
                var sql = 'UPDATE role SET activeflag = 0  where id = $1';
                return util.executeDBQuery(sql, [id]);
            }).then(data => {
                    newrole = data.count;
                    var sql = 'UPDATE teammemberroletype SET activeflag = 0  where roletypekey = $1';
                    return util.executeDBQuery(sql, [roletypekey]);
                }).then(reslt => {
                    newteammember = reslt.count;
                    return app.models.Roleresource.updateAll({
                        roleid:id
                    },{activeflag:0})
                   
                }).then(res =>{
                    const returndata = {};
                    returndata.role = newrole;
                    returndata.teammemberroletype = newteammember;
                    returndata.roleresource = res.count;
                    return returndata;
                })
                .catch (err =>err);  
            }                      
                      
	Roleresource.remoteMethod('Deleterole', {
        accepts: 
            {
                arg: 'id',
                type: 'string',
                required: true,
                http: { source: 'path' }
            },
        http: { "verb": "delete", "path": "/Deleterole/:id" },
        returns: {
            type: 'Object',
            root: true
        }
    });


    Roleresource.remoteMethod(
        'roleaddupdate', 
                {
                    http: {
                            path: '/roleaddupdate',
                            verb: 'post'
                    },
                    accepts : [ {arg : 'data',type : 'object',
                            http : {source : 'body'}},
                            {
                                arg: 'reqctx',
                                type: 'object',
                                http: {source: 'context'}
                              } ],   
                    returns: {
                        type : 'object',
                        root : true
                    }
                    }
    );



    Roleresource.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Roleresource.observe('access', (ctx, next) => util.access(ctx, next));
	Roleresource.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
