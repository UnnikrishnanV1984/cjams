/*
Issue:
CPS History Clearance Intake (I251013261033) was completed by the intake worker. However, the intake still appeared on the worker dashboard with a pending CANS-F assessment and showed as "In Review" in the search instead of being marked as "Closed". Additionally, a dummy case (251023031612) was linked and visible in the dashboard, causing confusion.
Root Cause:
The dummy service case (251023031612) was not removed from the system.
The "My Task" was showing a CANS-F assessment request linked to the dummy service case.
The intake submission history and status were not correctly updated to reflect closure.
Fix Provided (Data Fix Only):
Removed the dummy case 251023031612 and its associated records from:
intakeservicequest
activity
activitytask
Inserted a new routing record with corrected closure status and proper metadata for intake I251013261033.
Data/Code fix ticket#: CJAMS-59290
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data-only issue; no logic/code changes required.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update   intakeservicerequest
set  updatedby = 'CJAMS-59290',updatedon = now(), activeflag =0
where intakeserviceid in ('b6ddcd21-c5a4-4feb-b445-33eb31bf860b') and activeflag=1; 

--no routing records 

update activity
set activeflag = 0,updatedby = 'CJAMS-59290',updatedon = now()
where activityid in ('4fa5213e-a958-43a5-b00f-b41c9004ce5c') and activeflag =1;


update  activitytask
set activeflag = 0,updatedby = 'CJAMS-59290',updatedon = now()
where activitytaskid in ('1b2b8efd-849f-4272-bbb9-28ba226b2791',
'ba0f8b0a-dd16-4044-ab95-4d5d8a5fe21d') and activeflag =1;


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
'd483c7e1-d8c8-4772-aeca-4f06964e4e5f',
'd483c7e1-d8c8-4772-aeca-4f06964e4e5f',
'd196fdff-ae65-418e-96c4-f5df54ab6e33',
'CWIW',
'CWSP',
'I251013261033',
'8',
'1',
'CJAMS-59290',
'2025-04-08 00:00:00',
'd483c7e1-d8c8-4772-aeca-4f06964e4e5f',
'2025-04-08 00:00:00',
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
null,
null,
null);
