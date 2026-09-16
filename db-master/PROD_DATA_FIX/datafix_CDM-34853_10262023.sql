-- CDM-34853 - Enhancement request
/*
-- Issue Description: 
	User request to screen-out intake # I231011086707 and close back the service case # 3253805
   
	We need to ensure there is an audit trail saying 
	"This case was being screened out based on the family living in another state." 
	The Service Case should be disassociated with the Intake.  
   
-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: User error, the Intake was screen-in and connected to the service case 
-- Fix Provided: Datafix has been promoted to Screen-out the Intake and disassociate the Service case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Screen-out the Intake and disassociate the Service case. (CDM-34853)

-- Intake ID: I231011086707
-- Case ID: 3253805 - 19d47023-5ccc-46e0-a0b3-2e8894d39102

-- Screen-out Intake
update intakesnapshot
set updatedby = 'CDM-34853', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{DAType}',
				jsonb_set(jsondata->'DAType', '{DATypeDetail}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I231011086707' 
	and activeflag = 1;

update intakedastaging
set status = 'Closed',
	updatedby = 'CDM-34853', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{DAType}',
				jsonb_set(jsondata->'DAType', '{DATypeDetail}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I231011086707' 
	and activeflag = 1;

-- Update Supervisor Comments 
update intakesnapshot
set updatedby = 'CDM-34853', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{reviewstatus}',
			   jsonb_set(jsondata->'reviewstatus','{commenttext}', '"This case was being screened out based on the family living in another state."'))
where intakenumber = 'I231011086707' 
	and activeflag = 1;
	
update intakesnapshot
set updatedby = 'CDM-34853', 
	updatedon = now(), 
	jsondata = 	jsonb_set(jsondata, '{DAType}',
				jsonb_set(jsondata->'DAType', '{DATypeDetail}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supComments}', '"This case was being screened out based on the family living in another state."'))))
where intakenumber = 'I231011086707' 
	and activeflag = 1;	
	
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing
where routingid = '87a90f3d-0af3-4d06-ab75-dc3a39f435f8' 
	and objectid = 'I231011086707' ;

update routing
set routingstatustypeid = 8
where routingid = '87a90f3d-0af3-4d06-ab75-dc3a39f435f8'
	and objectid = 'I231011086707' ;

-- To disconnect I231011086707 and Service Case 3253805
select actiontype, servicerequestnumber, intakeserviceid, servicecaseid, activeflag, updatedby, updatedon 
	from intakeservicerequest
where intakenumber = 'I231011086707' ;

update intakeservicerequest
set servicecaseid = null,
	updatedby = 'CDM-34853',
	updatedon = now() 
where intakenumber = 'I231011086707' ;
	
-- Nullify Clients involvement form Service Case
select activeflag, intakeservicerequestpersontypekey, servicecaseid, activeflag, updatedby, updatedon 
	from intakeservicerequestactor 
where intakenumber = 'I231011086707'
	and servicecaseid = '19d47023-5ccc-46e0-a0b3-2e8894d39102'
	and activeflag = 1 ;

update intakeservicerequestactor
set servicecaseid = null,
	updatedby = 'CDM-34853',
	updatedon = now() 
where intakenumber = 'I231011086707'
	and servicecaseid = '19d47023-5ccc-46e0-a0b3-2e8894d39102'
	and activeflag = 1 ;

select activeflag, actortype, servicecaseid, activeflag, updatedby, updatedon 
	from actor 
where intakenumber = 'I231011086707'
	and servicecaseid = '19d47023-5ccc-46e0-a0b3-2e8894d39102'
	and activeflag = 1 ;

update actor
set servicecaseid = null,
	updatedby = 'CDM-34853',
	updatedon = now() 
where intakenumber = 'I231011086707'
	and servicecaseid = '19d47023-5ccc-46e0-a0b3-2e8894d39102'
	and activeflag = 1 ;
