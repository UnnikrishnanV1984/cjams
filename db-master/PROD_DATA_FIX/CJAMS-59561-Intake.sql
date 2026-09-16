/*
Issue:I231011318335:This intake keeps reappearing on my workload for approval. The decision should be screened out. The system will not allow the supervisors to finalize the decision. 
Root Cause:Intake 123101113835 was screened out but did not have a valid submission history for supervisor approval, so it kept reappearing in the supervisor's workload.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-59478
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakedastaging
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(jsondata ,'{DAType,DATypeDetail,0,DADisposition}','"ScreenOUT"',false ),
					'{DAType,DATypeDetail,0,supDisposition}','"ScreenOUT"',false),
				'{disposition,0,DADisposition}','"ScreenOUT"',false),
			'{disposition,0,supDisposition}','"ScreenOUT"',false),
		'{intakeDATypeDetails,0,DADisposition}','"ScreenOUT"',false),
	'{intakeDATypeDetails,0,supDisposition}','"ScreenOUT"',false),
	updatedby = 'CJAMS-59561', updatedon = now()
where intakenumber = 'I231011318335' and activeflag = 1;



insert into routing
(
routingid,                
eventcode,                
fromsecurityusersid,      
tosecurityusersid,        
teamid,                   
fromroleid,               
toroleid,                 
objectid,                 
routingstatustypeid,      
activeflag,               
insertedby,               
insertedon,               
updatedby,                
updatedon,                
isreviewrequest,          
remarks,                  
old_id,                   
routeddescription,        
servicerequestnumber,     
objecttypekey,            
old_from_id,              
old_to_id,                
principaltype,            
actiondatetime,           
etl_userid,               
etl_load_date,            
entityid,                 
reassignnotes,            
intakerecommendation,     
supervisordecision,       
approveddate)
values 
(gen_random_uuid(),
'INTR',
'95b57433-f7c8-4735-86af-87f726510a59',
'95b57433-f7c8-4735-86af-87f726510a59',
'6e742097-7f6d-4232-9025-7bd65fd4497e',
'CWIW',
'CWSP',
'I231011318335',
'8',
'1',
'CJAMS-59561',
now(),
'CJAMS-59561',
now(),
'true',
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Screenout',
'Screenout',
null);



update routing 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-59561'
where objectid = 'I231011318335' and updatedby  = 'CJAMS-59561' and activeflag =1;

update intakedastatus 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-59561'
where intakenumber  = 'I231011318335'  and activeflag =1;

update intakedastaging 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-59561'
where intakenumber  = 'I231011318335'  and activeflag =1;
