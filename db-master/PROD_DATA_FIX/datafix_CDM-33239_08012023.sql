-- CDM-33239 - Won't Allow Assignment or Closure
/*
-- Issue Description: 
	User request to screen out intake # I231010838321 and close back the service case # 3272020
   
-- Intake ID: I231010838321
-- Case ID: 3272020 - 0f85ab7c-5f14-4d69-91aa-efc968fb72ab
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: User error, the Intake was connected to the worng service case 
-- Fix Provided: Datafix has been promoted to Screen-out the Intake and close back the Service case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Screen-out the Intake and close back the Service case (CDM-33239)

-- Screen-out Intake
update intakesnapshot
set updatedby = 'CDM-33239', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{DAType}',
				jsonb_set(jsondata->'DAType', '{DATypeDetail}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I231010838321' 
	and activeflag = 1;

update intakedastaging
set status = 'Closed',
	updatedby = 'CDM-33239', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{DAType}',
				jsonb_set(jsondata->'DAType', '{DATypeDetail}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
				jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I231010838321' 
	and activeflag = 1;

select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing
where routingid = '4e417bdc-7ee5-487f-ab08-f0af170a7587' 
	and objectid = 'I231010838321' ;

update routing
set routingstatustypeid = 8
where routingid = '4e417bdc-7ee5-487f-ab08-f0af170a7587'
	and objectid = 'I231010838321' ;

-- To disconnect I231010838321 and Service Case 3272020
select actiontype, servicerequestnumber, intakeserviceid, servicecaseid, activeflag, updatedby, updatedon 
	from intakeservicerequest
where intakenumber = 'I231010838321' ;

update intakeservicerequest
set servicecaseid = null,
	updatedby = 'CDM-33239',
	updatedon = now() 
where intakenumber = 'I231010838321' ;

-- Close Service Case
select servicecasenumber, statustypekey, dispositioncode, enddate, updatedby, updatedon
	from servicecase
where servicecasenumber = '3272020'
	and activeflag  = 1 ;
	
update servicecase 
set statustypekey = 'Closed', 
	dispositioncode = 'Closed', 
	enddate = '2018-12-12 00:00:00', 
	updatedby = 'CDM-33239',
	updatedon = now() 
where servicecasenumber = '3272020' 
	and activeflag  = 1 ;

select intakeserreqstatustypekey, "comments", activeflag, updatedby, updatedon
	from servicecasedisposition
where servicecaseid = '0f85ab7c-5f14-4d69-91aa-efc968fb72ab'
	and servicecasedispositionid = '55d796ef-9f7b-4382-ab1c-fe811edb325a' ;

update servicecasedisposition
set activeflag = 0,
	updatedby = 'CDM-33239',
	updatedon = now() 
where servicecaseid = '0f85ab7c-5f14-4d69-91aa-efc968fb72ab'
	and servicecasedispositionid = '55d796ef-9f7b-4382-ab1c-fe811edb325a' ;
	
-- No updates required
/*	
select caseassignmentid, responsibilitytypekey, startdate, enddate, updatedby, updatedon 
	from caseassignment
where objectid = '0f85ab7c-5f14-4d69-91aa-efc968fb72ab'
	and activeflag = 1 
	and enddate is null ;
	
update caseassignment
set enddate = '2018-12-12 00:00:00', 
	updatedby = 'CDM-33239',
	updatedon = now() 
where objectid = '0f85ab7c-5f14-4d69-91aa-efc968fb72ab'
	and activeflag = 1 
	and enddate is null ;
*/

select eventcode, routingstatustypeid, servicerequestnumber, activeflag, updatedby, updatedon
	from routing
where objectid = '0f85ab7c-5f14-4d69-91aa-efc968fb72ab'
	and routingid = 'ccc0db65-91e4-4234-9698-fdd3c7887032'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-33239',
	updatedon = now() 
where objectid = '0f85ab7c-5f14-4d69-91aa-efc968fb72ab'
	and routingid = 'ccc0db65-91e4-4234-9698-fdd3c7887032'
	and activeflag = 1 ;
	
	