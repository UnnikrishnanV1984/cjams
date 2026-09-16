'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
const alreadyexists = "Already Exist";
const LOGGER = require("log4js").getLogger("Teammemberroletype");


module.exports = function(Teammemberroletype) {
	//for add user position dropdown;
	Teammemberroletype.teampositionlist = (id,request) => {
			return app.models.Teammember.find({
                fields:['teammemberid'],
            where:{
                teamid:id
            }
        }).then(data => {
            let prs = [];
            const teammember = JSON.parse(JSON.stringify(data));
            if(Array.isArray(teammember)){
                prs = teammember.map(element=> findElement(element));
                var flatprs = prs.reduce((a,b)=> a.concat(b),[]);
                return Promise.all(flatprs);
            }
                        
        }).then(data =>{
            return data.filter(value => Object.keys(value).length !== 0);
        })
	};

	const findElement =(element)  =>{
        const prs=[];
        var teammemberid = element.teammemberid;

        return app.models.Teammemberassignment.find({
                where:
                    {
						teammemberid :teammemberid
					}	
            })
        .then(res => {
         if(res.length === 0){
			prs.push( app.models.Teammember.findOne({
				fields:['teammemberid','positioncode','roletypekey'],
					where:{
					teammemberid:teammemberid   
					},
					include:{
						relation:'teammemberroletype',
						scope:{
							fields:['roletypekey'],
							include:{
								relation:'role',
								scope:{
									fields:['id','roletypekey']
								}
							}
						}
					}
			   }) 
		     )
			return Promise.all(prs);
		}
	  })
        .then(res =>{
			var returndata ={roleid: ''};
			if (res !== undefined && res.length > 0) {
				var data = JSON.parse(JSON.stringify(res));
				returndata.teammemberid = data[0].teammemberid;
				returndata.positioncode = data[0].positioncode;
				returndata.roletypekey = data[0].roletypekey;
				if (data[0].teammemberroletype !== undefined) {
					if ((data[0].teammemberroletype.role).length > 0) {
						returndata.roleid = data[0].teammemberroletype.role[0].id
					}
				}
			}
            return returndata;
          })
        };
	
  // for team and position position  title dropdown
	Teammemberroletype.list = (request) => {
		if(request.where.id !== undefined){
			return app.models.Team.findOne({
				where:{
					id:request.where.id
				}
			 }).then(data=>{
				 var typekey = data.teamtypekey;
				 if(data.teamtypekey == 'LDSS') 
				 {
					 typekey = undefined;
				 }
				 return Teammemberroletype.find({
					where:{
						teamtypekey:typekey
					},
					order : 'description asc',
					nolimit:true,
					fields:['roletypekey','description','teamtypekey']
				}).then(_res => _res)
				 .catch(err => util.logError(err))
			})
		}
		else { 
			 return Teammemberroletype.find({
				 where:request.where
			 })
			.then(data => data)
		    .catch(err => util.logError(err))
		 }
	  }

	Teammemberroletype.remoteMethod('list', {
		accepts : [
			{
				arg: 'filter',
			type: 'object',
				required: false,
				http: {source: 'query'}
			}
	],
		http: {"verb": "get", "path": "/list"},
		returns: {
			type: 'object',
			root : true
		}
	});

	//list remote method
	Teammemberroletype.remoteMethod('teampositionlist', {
		accepts : [{
				arg: 'id',
			   type: 'string',
				required: true,
				http: {source: 'path'}
			},
			{
				arg: 'filter',
			   type: 'object',
				required: false,
				http: {source: 'query'}
			}
	 ],
		http: {"verb": "get", "path": "/teampositionlist/:id"},
		   returns: {
			   type: 'object',
			   root : true
		   }
	 });

	 Teammemberroletype.roleadd =(request, reqctx) =>{

		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
		var description = request.description +',' + request.teamtypekey;
		var roletypecode,roletypekey,respond;
		     return app.models.Roletype.findOne({
				 where:{
					 roletypecode:request.roletypecode
				 },
				 fields:['roletypecode','shortname']
			 }).then(data =>{
				  roletypecode = data.roletypecode;
				  roletypekey = request.teamtypekey+roletypecode;
			 		return app.models.Teammemberroletype.find({
				    where:{
						roletypekey:roletypekey
					}
			         }).then(_data =>{
						 if(_data.length ===0){
							return app.models.Teammemberroletype.create({
								roletypekey:roletypekey,
								description:request.description,
								teamtypekey:request.teamtypekey,
								isroutable:true,
								isupervisor:request.issupervisable,
								insertedby: _securityusersid,
								updatedby: _securityusersid
						   })
						 }else{
                            return alreadyexists;
						 }
					 })
			
			 }).then(resp =>{
				if(resp === alreadyexists){
					return  alreadyexists;
				 }else{
					respond = JSON.parse(JSON.stringify(resp));
					roletypekey  = resp.roletypekey;
					  return app.models.Role.create({
						  name: request.rolename,
						 description:description,
						 roletypekey:roletypekey,
						 openamrole : request.openamrole,
						 insertedby: _securityusersid,
						 updatedby: _securityusersid
					  })	
				 }			 
				}).then(res =>{
					if(res !== alreadyexists){
						var returndata ={};
						returndata = respond;
						returndata.role = res;
						LOGGER.info(returndata);
						return 'Success';
					}else{
						return  alreadyexists;
				    }
			 })	
			 .catch(err => util.logError(err))
				}

	 Teammemberroletype.remoteMethod('roleadd', {
        http: {
                path: '/roleadd',
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
            type : 'string',
            root : true
        }
    });
	 
    Teammemberroletype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Teammemberroletype.observe('access', (ctx, next) => util.access(ctx, next));
    Teammemberroletype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
