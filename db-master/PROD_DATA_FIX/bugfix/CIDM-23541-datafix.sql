-- 
/*
 * CDM-23541 - Duplicate Removals GWhye
 	Issue Description: User request to delete the Duplicate Child Removal.  
 
 	Case ID: 221030015193
 	Client ID: 200888090  (Gabriel	Whye) - 1c507c16-3b36-430a-b0dc-e47f01965fb5
 	Removal IDs
			253773 --- 00437efd-daa8-464d-a9f4-e38ade0bb694 -- tobe deleted
			253772 --- 4cf27f0c-db70-4195-a1b3-466ed67382e9 -- make it as active

	Category/ Module: Child Removal (Case Management) 
	Root cause: User Error
	Pull request# N/A
	Reason why no related code fix: N/A
	Status of the code fix if already submitted and expected prod fix date: N/A
*/


/*RemovalId 253773 --- 00437efd-daa8-464d-a9f4-e38ade0bb694 -- tobe deleted */
select 	placementtypekey, alternateid, altproviderid, isvoided, startdatetime, enddatetime, intakeservreqchildremovalid, updatedby, updatedon 
from 	placement  
where 	personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5'
		and activeflag = 1;

update 	placement 
set 	intakeservreqchildremovalid = '4cf27f0c-db70-4195-a1b3-466ed67382e9',
		updatedby = 'CDM-23541',
		updatedon  = now()
where 	personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5' 
		and activeflag = 1 
		and intakeservreqchildremovalid = '00437efd-daa8-464d-a9f4-e38ade0bb694';
	
select 	rm.removalid, rm.intakeservreqchildremovalid, rm.personid , rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
from 	intakeservreqchildremoval rm 
where 	rm.personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5' 
		and rm.removalid = 253773
		and rm.activeflag = 1;
	
update 	intakeservreqchildremoval rm
set 	rm.activeflag = 0,
		rm.updatedby = 'CDM-23541',
		rm.updatedon = now() 		
where 	rm.removalid = 253773
		and rm.personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5' 
		and rm.activeflag = 1;

select 	* from routing ro 
where 	ro.eventcode = 'CHRR'
		and ro.objectid = '00437efd-daa8-464d-a9f4-e38ade0bb694'
		and ro.activeflag = 1;

update 	routing ro
set 	activeflag = 0,
		updatedby = 'CDM-23541',
		updatedon = now()
where 	ro.eventcode = 'CHRR'
		and ro.objectid = '00437efd-daa8-464d-a9f4-e38ade0bb694'
		and routingid = '4ac7f0cc-19a3-47e5-978b-9ae52f04e77d'
		and ro.activeflag = 1;

--No duplicates found in personprogramarea 
	
select 	eligibility_id, client_id, case_id, eligibility_status_cd, update_ts, update_user_id, delete_sw 
from 	tb_client_eligibility 
where 	removal_id = 253773
		and eligibility_status_cd = '2909'
		and delete_sw  = 'N';	

update 	tb_client_eligibility
set 	delete_sw = 'Y',
		update_user_id = 'CDM-23541',
		update_ts = now()
where 	removal_id = 253773
		and eligibility_status_cd = '2909'
		and delete_sw  = 'N';	

/* RemovalId 253772 -- Make it Active */
	
select 	placementtypekey, alternateid, altproviderid, isvoided, startdatetime, enddatetime, intakeservreqchildremovalid, updatedby, updatedon 
from 	placement  
where 	personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5'
		and activeflag = 1;

update 	placement 
set 	intakeservreqchildremovalid = '4cf27f0c-db70-4195-a1b3-466ed67382e9',
		updatedby = 'CDM-23541',
		updatedon  = now()
where 	personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5' 
		and activeflag = 1 
		and intakeservreqchildremovalid = '00437efd-daa8-464d-a9f4-e38ade0bb694';
	
select 	rm.removalid, rm.intakeservreqchildremovalid, rm.personid , rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
from 	intakeservreqchildremoval rm 
where 	rm.personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5' 
		and rm.removalid = 253772;
	
update 	intakeservreqchildremoval rm
set 	rm.activeflag = 1,
		rm.updatedby = 'CDM-23541',
		rm.updatedon = now() 		
where 	rm.removalid = 253772
		and rm.personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5' 
		and rm.activeflag = 0;

--Routing: No need to update routing. This record already has activeflag 1 for the approval for the respective intakeservreqchildremovalid


--Update startdate to 2022/03/30 in personprogramarea 
select 	personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
from 	personprogramarea 
where 	personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5'
		and personprogramid  = '754fd094-bfd0-4f20-a93d-af2c00db2381'
		and programkey = 'OOH'
		and enddate is null
		and activeflag = 1;

update 	personprogramarea 
set 	startdate  = '2022-03-30'
where 	personid = '1c507c16-3b36-430a-b0dc-e47f01965fb5'
		and personprogramid  = '754fd094-bfd0-4f20-a93d-af2c00db2381'
		and programkey = 'OOH'
		and enddate is null
		and activeflag = 1;

--Client Eligiblity: No need to update client eligibility. It has startdate of 2022/03/30 for the RemovalId 253772

	