-- CDM-24663 - Name change-removal changed
/*
-- Issue Description: 
   Client 200827461 missing in case 3293269
	All other issues are resolved we need to include the client 200827461 in case 3293269.

-- Case ID: 3293269 - a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c
-- Client ID: 200827461 (Sabreon Lee Anthony Sothern-Avery) - 615dab84-837a-4e76-b8d1-b62b5d7437e9

-- Category/ Module: Placements (Case Management) 
-- Root cause: User Error   
-- Fix Provided: Datafix has been add the Client # 200827461 back under Service Case #3293269
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select actorid, personid, servicecaseid, activeflag, updatedby, updatedon
	from actor
where actorid = '23d04477-a46b-49ba-af2f-09ad89da9dd3'
	and activeflag = 0;

update actor  
set activeflag = 1,
	updatedon = now(), 
	updatedby = 'CDM-24663'
where actorid = '23d04477-a46b-49ba-af2f-09ad89da9dd3'
	and activeflag = 0;

-- Update Removal Service Case
select servicecaseid, removalid, removaldate, exitdate, activeflag, updatedby, updatedon 
	from intakeservreqchildremoval
where removalid = 253418
	and activeflag = 1 ;

update intakeservreqchildremoval
set servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',
	updatedon = now(), 
	updatedby = 'CDM-24663'
where removalid = 253418
	and activeflag = 1 ;
	
-- Program Assignment 	
select programkey, startdate, enddate, objectid, objecttypekey, entityid, updatedon, updatedby  
	from personprogramarea 
where personid = '615dab84-837a-4e76-b8d1-b62b5d7437e9'
	and programkey = 'OOH'
	and personprogramid  = '007d8ef6-6ad2-4561-a1d8-f24e77646466' ;

update personprogramarea
set objectid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',
	entityid = '3293269',
	updatedon = now(), 
	updatedby = 'CDM-24663'	
where personid = '615dab84-837a-4e76-b8d1-b62b5d7437e9'
	and programkey = 'OOH'
	and personprogramid = '007d8ef6-6ad2-4561-a1d8-f24e77646466' ;

-- IV-E 
select eligibility_id, case_id, update_user_id, update_ts  
	from tb_client_eligibility 
where removal_id = 253418
	and delete_sw = 'N' ;
	
update tb_client_eligibility	
set case_id = 3293269,
	update_user_id = 'CDM-24663',
	update_ts = now()
where removal_id = 253418
	and delete_sw = 'N' ;	