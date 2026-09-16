/*
Issue Description: Please do a data fix to remove the supervisor decision in the dropdown and submission history and make sure the intake is displaying in the Supervisor's pending review dashboard.Supervisor - megan.mccaskill@maryland.gov Supervisor decision - Blank Status - Review
Root cause: The user requested to clear the supervisor fields and keep the status unchanged, so it shows up in the pending supervisor dashboard. This is needed because the user doesn’t have the required access to do it.
Fix provided: update into routing,intakedastatus,intakedastaging,intakesnapshot table
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User Error.
*/

update routing 
set supervisordecision = null, updatedby = 'CJAMS-62658',routingstatustypeid ='1',	updatedon  =now()
where routingid  ='8ef04b1a-a35c-4a83-bd3d-8d5c2e17e86a' and activeflag =1;

update intakedastatus 
set ispreintake = false, status = 1, updatedby = 'CJAMS-62658', updatedon = now()
where intakenumber = 'I251013370906' and activeflag = 1;

update intakedastaging
set ispreintake = false, jsondata = jsonb_set(	
							jsonb_set(
								jsonb_set(jsondata ,'{DAType,DATypeDetail,0,supDisposition}','""',false),											
			'{disposition,0,supDisposition}','""',false),		
	'{intakeDATypeDetails,0,supDisposition}','""',false),
	updatedby = 'CJAMS-62658', updatedon = now(),status ='pending'
where intakenumber = 'I251013370906' and activeflag = 1;

update intakesnapshot
set jsondata = jsonb_set(	
							jsonb_set(
								jsonb_set(jsondata ,'{DAType,DATypeDetail,0,supDisposition}','""',false),											
			'{disposition,0,supDisposition}','""',false),		
	'{intakeDATypeDetails,0,supDisposition}','""',false),
	updatedby = 'CJAMS-62658', updatedon = now()
where intakenumber = 'I251013370906' and activeflag = 1;