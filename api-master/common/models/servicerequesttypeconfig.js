'use strict';
const LOGGER = require("log4js").getLogger("servicerequesttypeconfig");
const util = require('../utils/utils');

var server = require('../../server/server');
module.exports = function(Servicerequesttypeconfig) {

var totalCount;
	Servicerequesttypeconfig.remoteMethod('addtypeconfig', {
		http : {
			path : '/addtypeconfig',
			verb : 'post'
		},
		accepts : [ {
			arg : 'data',
			type : 'object',
			http : {
				source : 'body'
			}
		} ],
		returns : {
			type : 'object',
			root : true
		}
	});

	Servicerequesttypeconfig.addtypeconfig = function(data){
	 return	Servicerequesttypeconfig.find({
			where:{and:[{intakeservreqtypeid:data.where.intakeservreqtypeid},
				{servicerequestsubtypeid: data.where.servicerequestsubtypeid},
				{intakeservicerequestplantypekey : data.where.intakeservicerequestplantypekey},
				{category:data.where.category}]}
		}).then(res => {
			if(res.length  === 0){
				return Servicerequesttypeconfig.create(data.where);
			}else if(res.length > 0){
				return "Already Exist";
			}
		}).catch(err => err);
		}
		

	function validateinput(str) {
		if (str === 'undefined') {
			return null;
		} else {
			return str;
		}

	}

	Servicerequesttypeconfig.gettypeconfiglist = function(data) {
		totalCount = 0;
		var sortby ='insertedon';
		var sortorder='desc'
		var filtercol='datype';
		var filtervalue='';
		var obj = data.where;
		if (obj !==null && obj !==undefined)
		{
			
			if(Object.keys(obj)[0].toLowerCase() !="activeflag")
			{
				filtercol =Object.keys(obj)[0] ;
				var obj1 = obj[Object.keys(obj)[0]];
				if (obj1 !==null && obj1 !==undefined)
				{
					filtervalue=obj1[Object.keys(obj1)[0]];
				}
			}
		}

		if (util.isNullorEmpty(data.order))
			{
				var sordrby = data.order.trim().split(" ");
				if (sordrby.length > 1)
				{
				sortby=  sordrby[0];
				sortorder = sordrby[sordrby.length-1];

				}
			}
		 
		var sql = 'select * from getdatypeconfiglistnew($1,$2,$3,$4,$5,$6)';

		
		LOGGER.debug(data.page + '\',\'' + data.size + '\',\''+ validateinput(data.orderby));

		LOGGER.debug("SQL :" + sql);

		var params = [data.page,data.limit,filtercol,filtervalue,sortby,sortorder];

		return util.executeDBQuery(sql, params)
			.then(data1 => {
				if (data1.length>0 ) {totalCount = data1[0].totalcount;}
				return data1;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};
	Servicerequesttypeconfig.afterRemote('gettypeconfiglist', function(ctx, data, next) {
		if (ctx.result) {
			ctx.result = {
				'data' :  data ,
				'count' : totalCount
			};
		}
		next();
	});
	Servicerequesttypeconfig.remoteMethod('gettypeconfiglist', {
		http : {
			path : '/gettypeconfiglist',
			verb : 'post'
		},
		accepts : [ {
			arg : 'data',
			type : 'object',
			http : {
				source : 'body'
			}
		} ],
		returns : {
			type : 'object',
			root : true
		}
	});
	
	
	Servicerequesttypeconfig.remoteMethod('dispositionlist', {
	    accepts : [
	        {
	            arg: 'filter',
	            type: 'Object',
	            required: true,
	            http: {source: 'query'}
	        },
	        
	],
	http:{"verb": "get", },
		returns : {
			type : 'Object',
			root : true
		}
	});
	
	Servicerequesttypeconfig.dispositionlist = function (arg) {
		const intakeserviceid = arg.where.intakeserviceid;
		return server.models.Intakeservicerequest.find({
			where: {
				and: [{ intakeserviceid: intakeserviceid }, { activeflag: true }],
				fields: ['intakeserviceid', 'intakeservicerequestclassid', 'intakeserreqstatustypeid', 'intakeservreqtypeid']
			}
		}).then(intakeidobj1 => {
			return Promise.all(intakeidobj1.map(intakeidobj => Servicerequesttypeconfig.find({
				where: { and: [{ activeflag: true }, { intakeservreqtypeid: intakeidobj.intakeservreqtypeid }, { servicerequestsubtypeid: intakeidobj.intakeservicerequestclassid }] },
				fields: ['servicerequestsubtypeid', 'intakeservreqtypeid', 'servicerequesttypeconfigid'],
				include: {
					relation: 'servicerequesttypeconfigdispositioncode',
					scope: {
						fields: ['intakeserreqstatustypeid', 'dispositioncode', 'description', 'servicerequesttypeconfigid'],
						where: { and: [{ activeflag: true }, { intakeserreqstatustypeid: intakeidobj.intakeserreqstatustypeid }] }

					}
				}

			})
			));
		}).then(disp => {
			var flatitems = disp.reduce((a, b) => a.concat(b), []);
			const dispo = JSON.parse(JSON.stringify(flatitems));
			const flatitem = dispo.map(dis => dis.servicerequesttypeconfigdispositioncode);
			flatitems = flatitem.reduce((a, b) => a.concat(b), []);
			return flatitems;
		});

	};

		
		
	Servicerequesttypeconfig.remoteMethod('reasonlist', {
	    accepts : [
	        {
	            arg: 'filter',
	            type: 'Object',
	            required: true,
	            http: {source: 'query'}
	        },
	        
	],
	http:{"verb": "get", },
		returns : {
			type : 'Object',
			root : true
		}
	});

	
	
	Servicerequesttypeconfig.reasonlist = function(arg) {

	return server.models.Intakeservicerequesttype.find({
		fields:['intakeservreqtypeid','intakeservreqtypekey'],
		where :{and:[{intakeservreqtypekey:'RF'}]},
		include:{
			relation : 'servicerequesttypeconfig',
				scope:{
					where :{and:[{activeflag:true}]},
					fields:['servicerequestsubtypeid','intakeservreqtypeid'],
					include:{
						relation : 'servicerequestsubtype',
							scope:{
								fields:['servicerequestsubtypeid','classkey','description'],
						 }   
					} 
				}
				  
			}  
	})
	.then(data => {
	 const isrTypes = JSON.parse(JSON.stringify(data));
	 const srtConfigs = isrTypes.map(x => x.servicerequesttypeconfig).reduce((a,b) => a.concat(b), []);
	 //return srtConfigs;
	 return srtConfigs.map(x => x.servicerequestsubtype).reduce((a,b) => a.concat(b), []);
	})
	.catch(err => util.logError(err));

};

	Servicerequesttypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Servicerequesttypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
	Servicerequesttypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
