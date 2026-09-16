'use strict';
const LOGGER = require("log4js").getLogger("auditlog");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Auditlog) {

	Auditlog.remoteMethod('list', {
        accepts: {
        arg: 'filter',
        type: 'Object',
        http: {
          source: 'query',
        },
        required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
	});
	Auditlog.list = request => {
    var referenceid = request.where.referenceid;
		var logType =  request.where.logType;
		var removalDate =  request.where.removalDate;
		var rangeType =  request.where.rangeType;
		// rangeType = 1 0-60 
		// rangeType = 2 61-90
		// rangeType = 3 91-180
		// rangeType = 4 180
		  var sql = ' select audit.*,up.displayname, ' +
					  ' (select Json_agg(aa) from (select PNT.description::character varying as Recordingtypedescription, ' +
					  ' COALESCE(PNT.progressnotetypekey, \'\') AS RecordingType, ' +
					  ' PN.locationname, ' +
					  ' COALESCE((SELECT pns.description FROM progressnotesubtype pns ' +
					  ' where pns.progressnotesubtypeid = PN.progressnotesubtypeid), \'\') AS RecordingSubType ' +
					  ' from ProgressNote AS PN' +
					  ' inner join ProgressNoteType AS PNT ' +
					  ' on PNT.ProgressNoteTypeId = PN.ProgressNoteTypeId ' +
					  ' and pn.activeflag=1 and pnt.activeflag=1 ' +
					  ' and pn.progressnoteid = audit.referenceid) ' +
					  ' aa) :: jsonb AS contactdetails from auditlog audit ' +
					  ' left join userprofile up' +
					  ' on audit.insertedby=up.securityusersid ' +
					  ' where referenceid=$1 and logtypekey=$2 ';
		  var params = [];
		  params.push(referenceid);
		  params.push(logType);
		  if(rangeType){
			sql = sql + ' and audit.insertedon>$3 and audit.insertedon<$4';
			params.push(removalDate);
			switch(rangeType){
				case 1:params.push(Auditlog.addDays(removalDate,60));
					   break;
				case 2 :params.push(Auditlog.addDays(removalDate,90));
						break; 
				case 3 :params.push(Auditlog.addDays(removalDate,180));
						break; 
				default:params.push(new Date());
				        break;
			}
			
			}
			sql = sql + ' order by audit.insertedon desc ';
        return util.executeDBQuery(sql, params)
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
	  };
	  
	  Auditlog.addDays = (date, days) => {
			var result = new Date(date);
			var data= new Date(date);
			result.setDate(data.getDate() + days);
			return result;
	  }
	 
	Auditlog.createlogdetails = (request)=>{
		if(request.intakeserviceid != '00000000-0000-0000-0000-000000000000' && request.intakeserviceid != undefined )
		{
			return app.models.Intakeservicerequest.findOne(
				{where:
					{intakeserviceid:request.intakeserviceid}
					,fields:['servicerequestnumber']
				}).then(response => {
						request.servicerequestnumber = response.servicerequestnumber;
						request.metadata.data.danumber  = response.servicerequestnumber;
						return response;
					}).then(reslt =>{
					return app.models.Auditlogtype.find(
						{where:{logtypekey:request.logtypekey},fields:['logtypekey']})
					}).then(data =>{
						return Auditlog.create(request)
					})
			 .catch(err => err)
		}else{
			request.logtypekey = 'IAT';
			return app.models.Auditlogtype.find(
				{where:{logtypekey:request.logtypekey},fields:['logtypekey']
			}).then(data =>{
				return Auditlog.create(request)
			})
		}
		
	  }
	 
	  Auditlog.addupdate = (request)=>{
		
		return Auditlog.create(request);
		
	  }
	  Auditlog.remoteMethod (
		'addupdate',
	   {
		 http: {
			 path: '/addupdate',
			 verb: 'post'
		 },
		 accepts: [{
			 arg: 'request',
			 type: 'Object',
			 http: {
			   source: 'body'
			 }
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
	  Auditlog.createLogWithReferenceType = (request)=>{ 
		return app.models.Auditlogtype.find(
			{where:{logtypekey:request.logtypekey},fields:['logtypekey']
		}).then(data =>{
			return Auditlog.create(request)
		})
	  }

		Auditlog.remoteMethod('listbyobjectid', {
			http: {
				path: '/listbyobjectid',
				verb: 'get'
			},
			accepts: [{
				arg: 'filter',
				type: 'object',
				http: {
					source: 'query'
				}
			}],
			returns : {
				type : 'string',
				root : true
			}
		});


		Auditlog.listbyobjectid = (request) => {
			var objectid = request.where.objectid ? request.where.objectid : null;
			var casenumber = request.where.casenumber ? request.where.casenumber : null;
			var updatedfrom ='';
			var updatedto ='';
			var updatedby ='';
			var sortcol ='';
			var sortby ='';

			if(request.where.updatedfrom !== undefined){
					updatedfrom=request.where.updatedfrom;
			}
			if(request.where.updatedto !== undefined){
					updatedto=request.where.updatedto;
			}
			if(request.where.updatedby !== undefined){
					updatedby=request.where.updatedby;
			}

			if(request.where.sortcol !== undefined){
				sortcol=request.where.sortcol;
			}
			if(request.where.sortby !== undefined){
				sortby=request.where.sortby;
			}
 
						 	var sql = 'select * from getauditloglistbyobjectid($1,$2,$3,$4,$5,$6,$7,$8,$9)';
								
								return util.executeSecondaryNodeDBQuery(sql, [objectid,request.page, request.limit,
									sortby,sortcol,updatedfrom,updatedto,updatedby,casenumber]).then((data)=>{
										return data;
								}).catch((err)=>{ LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });

	};


		
	Auditlog.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Auditlog.observe('access', (ctx, next) => util.access(ctx, next));
	Auditlog.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};