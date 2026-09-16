'use strict';
const LOGGER = require("log4js").getLogger("activitytask");
var server = require('../../server/server');
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Activitytask) {
	 var acttaskintakeserviceid;// Added for auditlog
		Activitytask.add= function(request) {
			acttaskintakeserviceid = request.intakeserviceid; 
		const activitytask = request.task;
		if   (util.isNullorEmpty(activitytask[0].activitytaskid)){
			LOGGER.debug('yes')
		if(Array.isArray(activitytask)){
			var response = []; 		
			const prs = updateActivityTasks(activitytask);
	 return Promise.all(prs).then(function(values) {
		values.map(x=>{
			response.push(x);
		});
		return response;
	  }).then(res =>{
		var intakeserviceid = request.intakeserviceid;   
		 const sql = 'SELECT * FROM insertduplicateactivitytask($1)';
		return util.executeDBQuery(sql, [intakeserviceid])
		.then(data =>{
				var sql1 = 'SELECT * FROM createduplicateactivitytask($1)';
				return util.executeDBQuery(sql1, [intakeserviceid]).then(()=>{
					return 'Success';
				}).catch(err=>{
					LOGGER.error(err);
				});
			}).catch(err=>{
				LOGGER.error(err);
			});
	  	})
  }
}
		else   {	
		const sql = 'Select  loadnumber from teammember where teammemberid  in (select  teammemberid from areateammemberservicerequest where IntakeServiceId = $1 and activeflag =1) order by insertedon asc limit 1';
	
		return util.executeDBQuery(sql, [request.intakeserviceid])
	    .then(data => { 
        	if(data!=null){
        		
        		var loadnumber = data[0].loadnumber
            	LOGGER.debug('--loadnumber--'+loadnumber)
            	const prs = [];

			const currentDate = new Date().toLocaleString();
			activitytask.forEach(at => {
				at.assignedto = loadnumber;
				at.assignedon = currentDate;
			});
			
			
			LOGGER.debug('333333'+JSON.stringify(activitytask))
  	      prs.push(
  	    		  activitytask.map(newActivitytask => app.models.Activitytask.create(newActivitytask))
  	      );
  	      
			var activitygoal = request.goal;

			activitygoal.forEach(ag=>{
				ag.assignedto = loadnumber;
			})
	
  	      prs.push(
  	    		  activitygoal.map(newActivityGoal => app.models.Activitygoal.create(newActivityGoal))
  	      );


  	      var flatPrs = prs.reduce(function(a,b){ return a.concat(b) }, []);

      	        return Promise.all(flatPrs)
      	        .then(data1 => data1)
      	        .catch(err =>err);
        	}
        	
        }).catch(err=>{
			LOGGER.error(err);
		});
	
	        
	}
		return Promise.resolve('Invalid request');
	};
	
	function updateActivityTasks(activitytask) {
		var prs = [];
		activitytask.forEach(element => {
			var taskdetails = element;
			var duedate = taskdetails.duedate;
			var iscontinual = taskdetails.iscontinual;
			var remainderdate = iscontinual !== true ? util.subtractDays(duedate, 45) : util.subtractDays(duedate, 25);
			LOGGER.debug(remainderdate);

			if (util.isNullorEmpty(taskdetails.activitytaskid)) {
				if (taskdetails.notes == null || taskdetails.notes === undefined) { taskdetails.notes = null; }
				app.models.Activitytask.updateAll(
					{ activitytaskid: taskdetails.activitytaskid },
					{
						activitytaskstatustypekey: taskdetails.activitytaskstatustypekey,
						activitytaskdispositiontypekey: taskdetails.activitytaskdispositiontypekey,
						completeddate: taskdetails.completeddate,
						duedate: duedate,
						reminderdate: (taskdetails.activitytaskstatustypekey === 'InvOpen') ? remainderdate : null,
						//reminderdate:remainderdate,
						taskdispositiontypekey: taskdetails.taskdispositiontypekey,
						notes: taskdetails.notes
					}
				).then(function (rest) {
					prs.push(rest);
				});
			}

		})
		return prs;
	}

	 Activitytask.description =(v_ammappingid) =>{
		return app.models.Ammapping.findOne({
			where:{
			   ammappingid:v_ammappingid, 
			},
			fields:['name','description','helptext']
		   }).then(data =>{
			   return data;
		   })
	
	 } 

	Activitytask.taskadd =(request,v_activityid, _securityusersid)=>{
	
      var  task =request.activitytask;
	  const response = [];
	  var result = [];
	  const currentDate = new Date().toLocaleString();
	  
		if(Array.isArray(task)){
			task.forEach(element=>{
				response.push(
					app.models.Activitytask.create({
						activityid :v_activityid,
						name: element.name,
						description :element.description ,
						helptext: element.helptext,
						amtaskid:element.amtaskid,
						assignedto:(request && request.securityuserid?request.securityuserid: _securityusersid),
						assignedon:currentDate,
						activitytaskstatustypekey: element.activitytaskstatustypekey,
						activitytaskdispositiontypekey:element.activitytaskdispositiontypekey,
						activitytasktypekey:element.activitytasktypekey,
						activityprioritytypekey:element.activityprioritytypekey,
						required:element.required,
						taskcommunicationtypekey:request.taskcommunicationtypekey,
						insertedby:(request && request.securityuserid?request.securityuserid: _securityusersid),
						updatedby:(request && request.securityuserid?request.securityuserid: _securityusersid),
						iseditable:element.iseditable
		
				})
			  )
			}) 
			return Promise.all(response).then(function(values) { 
				values.map(x=>{                         
					result.push(x);                           
				}); 
				return result;
			  });  
		}
	}


	Activitytask.addtask =(request, reqctx)=>{
		let _securityusersid = undefined;
        if(reqctx?.req?.headers?.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }
		var securityusersid = (request?.securityuserid ? request.securityuserid : _securityusersid);
		var v_activityid,name,description,helptext;
		return app.models.Activity.findOne({
			where:{
			  amactivityid: request.amactivityid,
			  ammappingid:request.ammappingid,
			  objectid:request.intakeserviceid
			}
		}).then(res =>{
			LOGGER.debug(res + "res");
			if( res === null || res.length === 0 ){
		
				return Activitytask.description(request.ammappingid)
				.then(res1 =>{
					name =res1.name;
					description= res1.description;
					helptext = res1.helptext;

					return app.models.Activity.create({
						description:name,
						amactivityid:request.amactivityid,
						ammappingid:request.ammappingid,
						objectid:request.intakeserviceid,
						activitytypekey:request.activitytypekey,
						sourcedescription:description,
						helptext:helptext,
						insertedby:securityusersid,
						updatedby:securityusersid,
						iseditable:request.iseditable
					}).then(result =>{
						LOGGER.debug(result + "result");
						var activityid = result.activityid;
						 return Activitytask.taskadd( request,activityid, _securityusersid);
	
					})
				})
				
			}else{
			
				v_activityid= res.activityid
				return Activitytask.taskadd( request,v_activityid, _securityusersid);
			}
		}).then(resp =>{
			var returndata ={};
		 returndata.activitytask = resp;
		 return returndata;
		})
	}

    Activitytask.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],   
        returns: {
            type : 'object',
            root : true
        }
	});



	Activitytask.remoteMethod('addtask', {
        http: {
                path: '/addtask',
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

	// NOSONAR
	// Activitytask.intakeservice =(activityid)=>{
	// 	 return app.models.Activity.findOne({
	// 		where:{activtyid:activityid},
	// 		fields:['objectid']
	// 	  }).then(data => {
	// 		  LOGGER.debug(data + "data")
	// 		  intakeserviceid = data.objectid;
	// 	  })

	// }

	

	Activitytask.observe('after save', function (ctx, next) {
		var intakeserviceid,description ,referenceid,Servicerequestnumber,isnew,isedit,isdelete;
		   var logJson ={
			"data": {
				"activityid":"",
				"status":"",
				"type":"",
				"disposition":"",
				"amtaskid":"",
				"helptext":"",
				"isSelected":"",
				"name":"",
				"required":"",
				"createtaskintakeserviceid":""
			}
		}
        var logtypekey = "IPT"; /**/
        
          if (ctx.isNewInstance) //CREATE
          { 
			description = "Task (Type: "+ctx.instance.activitytasktypekey+",Name: "+ctx.instance.name +", Status: "+ctx.instance.activitytaskstatustypekey+", Disposition :"+ ctx.instance.activitytaskdispositiontypekey+ ") added to DA#";
			intakeserviceid = acttaskintakeserviceid;		
            referenceid = ctx.instance.activitytaskid;
            isnew = true;
            logJson.data.activityid = ctx.instance.activityid;
            logJson.data.amtaskid = ctx.instance.amtaskid;
            logJson.data.name = ctx.instance.name;
			logJson.data.type = ctx.instance.activitytasktypekey;
			logJson.data.status = ctx.instance.activitytaskstatustypekey;
			logJson.data.disposition = ctx.instance.activitytaskdispositiontypekey;
			logJson.data.isSelected = ctx.instance.isSelected;
			logJson.data.createtaskintakeserviceid =acttaskintakeserviceid;	
				
			var newadd = {
				    "description":description,
					"logtypekey":logtypekey ,
					"intakeserviceid": intakeserviceid,
					"referenceid": referenceid,
					"servicerequestnumber":Servicerequestnumber,
					"metadata":logJson,
					"isnew":isnew,
					"isedit":isedit,
					"isdelete":isdelete
				}
				
				server.models.Auditlog.createlogdetails(newadd);
				next();  
		} 
    })
	

      
    Activitytask.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Activitytask.observe('access', (ctx, next) => util.access(ctx, next));
	Activitytask.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
