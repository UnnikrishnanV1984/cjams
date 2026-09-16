
/*
Issue Description:The case plan review requests are still available in Caseworker's and Supervisor's dashboard for 2 cases. Both are in approved status but did not got removed from the pending approval dashboard after approval.
Root cause: User request to update the data into in below fields.
1. Do administrative override and screen out the intake.
2. Delete the CPS case
3. Display administrative override table
4. Update the submission History
5. Update the provided text in the Addendum to Narrative field(Narrative tab)
6. Update Reason for delay
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-60895
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
delete from routing where objectid = 'I251013298639';
delete from routing where objectid = 'I251013298639'  and insertedby = '8d192f5a-28fa-4a57-8c27-345e61ceb8f7' and updatedby = '8d192f5a-28fa-4a57-8c27-345e61ceb8f7';
delete from administrativeoverrides where updatedby = 'CJAMS-60895';
*/
-- Display administrative override table
insert into administrativeoverrides
(administrativeoverrideid,referralsnapshotid,overridestaffid,activeflag,overridekeyid,approvalid,entitytypekey,entityid,overridereasontypekey,overridedate,overridetimestamp,updatedby,updatedon,insertedby,insertedon,intakeserviceid)
values
(gen_random_uuid(),gen_random_uuid(),'63fb46b7-bd92-407f-914a-2ffdc3c2d81f','1','1','00000000-0000-0000-0000-000000000000','2530','I251013298639','RISI','06-04-2025',now(),'CJAMS-60895',now(),'63fb46b7-bd92-407f-914a-2ffdc3c2d81f',now(),'e90e22ec-9c06-4a2b-8b7b-3c5fa52c5f59');


--Do administrative override and screen out the intake.,Update Reason for delay
update intakedastaging
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(jsondata ,'{DAType,DATypeDetail,0,DADisposition}','"ScreenOUT"',false ),
							'{DAType,DATypeDetail,0,reason}','"staffing/ supervisor delays"',false ),
					'{DAType,DATypeDetail,0,supDisposition}','"ScreenOUT"',false),
				'{disposition,0,DADisposition}','"ScreenOUT"',false),
			'{disposition,0,supDisposition}','"ScreenOUT"',false),
		'{intakeDATypeDetails,0,DADisposition}','"ScreenOUT"',false),
	'{intakeDATypeDetails,0,supDisposition}','"ScreenOUT"',false),
	updatedby = 'CJAMS-60895', updatedon = now()
where intakenumber = 'I251013298639' and activeflag = 1;

update intakesnapshot
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(jsondata ,'{DAType,DATypeDetail,0,DADisposition}','"ScreenOUT"',false ),
							'{DAType,DATypeDetail,0,reason}','"staffing/ supervisor delays"',false ),
					'{DAType,DATypeDetail,0,supDisposition}','"ScreenOUT"',false),
				'{disposition,0,DADisposition}','"ScreenOUT"',false),
			'{disposition,0,supDisposition}','"ScreenOUT"',false),
		'{intakeDATypeDetails,0,DADisposition}','"ScreenOUT"',false),
	'{intakeDATypeDetails,0,supDisposition}','"ScreenOUT"',false),
	updatedby = 'CJAMS-60895', updatedon = now()
where intakenumber = 'I251013298639' and activeflag = 1;


--Update the submission History
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
'63fb46b7-bd92-407f-914a-2ffdc3c2d81f',
'8d192f5a-28fa-4a57-8c27-345e61ceb8f7',
'b24a21eb-0261-4755-84b0-e5e38188286c',
'CWIW',
'CWSP',
'I251013298639',
'860',
'1',
'8d192f5a-28fa-4a57-8c27-345e61ceb8f7',
'06-04-2025',
'8d192f5a-28fa-4a57-8c27-345e61ceb8f7',
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
'Scrnin',
'Navigate to Narrative',
'06-04-2025');



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
'63fb46b7-bd92-407f-914a-2ffdc3c2d81f',
'8d192f5a-28fa-4a57-8c27-345e61ceb8f7',
'b24a21eb-0261-4755-84b0-e5e38188286c',
'CWIW',
'CWSP',
'I251013298639',
'8',
'1',
'8d192f5a-28fa-4a57-8c27-345e61ceb8f7',
'06-04-2025',
'8d192f5a-28fa-4a57-8c27-345e61ceb8f7',
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
'Scrnin',
'screenout',
'06-04-2025');

--Delete the CPS case
update intakeservicerequest
set activeflag = 0,  actiontype = null,updatedby = 'CJAMS-60895', updatedon = now()
where intakenumber = 'I251013298639' and activeflag =1;

--Update the provided text in the Addendum to Narrative field(Narrative tab)
UPDATE intakesnapshot
SET jsondata = jsonb_set(
                 jsondata::jsonb, 
                 '{General, addendumNarrative}', 
                 '"After admin review, this case does not meet SDM requirements and will be screened out."'::jsonb, 
                 true
              ),
    updatedby = 'CJAMS-60895', 
    updatedon = now()
WHERE intakenumber = 'I251013298639' 
  AND activeflag = 1;
