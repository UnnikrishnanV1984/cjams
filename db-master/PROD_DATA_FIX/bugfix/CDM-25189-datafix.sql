-- CDM-25189 - Duplicate Removal
/*
-- Issue Description: 
    User request to delete the Duplicate Child Removal.  
    
-- Case ID: 3304128
-- Client ID: 200949654  (Elijah Xavier Conner) - 9095f755-f89d-4542-936a-692ea119c99b
-- Removal IDs
-- 254617 - 2022-09-01 00:00:00.000 To NULL - a9216fde-9938-47cd-b4a6-926f7aae97e2 -- Delete
-- 254614 - 2022-09-01 00:00:00.000 To NULL - 4f6b34aa-47b6-4713-b34d-b384a69637c9  

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	placementtypekey, alternateid, altproviderid, isvoided, startdatetime, enddatetime, intakeservreqchildremovalid, updatedby, updatedon 
from 	placement  
where 	personid = '9095f755-f89d-4542-936a-692ea119c99b'
		and activeflag = 1 ;

update 	placement 
set 	intakeservreqchildremovalid = '4f6b34aa-47b6-4713-b34d-b384a69637c9',
		updatedby = 'CDM-25189',
		updatedon  = now()
where 	personid = '9095f755-f89d-4542-936a-692ea119c99b' 
		and activeflag = 1 
		and intakeservreqchildremovalid = 'a9216fde-9938-47cd-b4a6-926f7aae97e2';
	
select 	rm.removalid, rm.intakeservreqchildremovalid, rm.personid , rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
from 	intakeservreqchildremoval rm 
where 	rm.personid = '9095f755-f89d-4542-936a-692ea119c99b' 
		and rm.removalid = 254617
		and rm.activeflag = 1 ;
	
update 	intakeservreqchildremoval rm
set 	rm.activeflag = 0,
		rm.updatedby = 'CDM-25189',
		rm.updatedon = now() 		
where 	rm.removalid = 254617
		and rm.personid = '9095f755-f89d-4542-936a-692ea119c99b' 
		and rm.activeflag = 1 ;

select 	* from routing ro 
where 	ro.eventcode = 'CHRR'
		and ro.objectid = 'a9216fde-9938-47cd-b4a6-926f7aae97e2'
		and ro.activeflag = 1 ;

update 	routing ro
set 	activeflag = 0,
		updatedby = 'CDM-25189',
		updatedon = now()
where 	ro.eventcode = 'CHRR'
		and ro.objectid = 'a9216fde-9938-47cd-b4a6-926f7aae97e2'
		and ro.activeflag = 1 ;

--No duplicates found in personprogramarea 
--select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
--	from personprogramarea 
--where personid = '9095f755-f89d-4542-936a-692ea119c99b'
--	and personprogramid  = '758ebb16-4442-4488-ba88-eba0d955b475'
--	and programkey = 'OOH'
--	and enddate is null
--	and activeflag = 1 	;

	
select 	eligibility_id, client_id, case_id, eligibility_status_cd, update_ts, update_user_id, delete_sw 
from 	tb_client_eligibility 
where 	removal_id = 254617
		and eligibility_status_cd = '2909'
		and delete_sw  = 'N' ;	

update 	tb_client_eligibility
set 	delete_sw = 'Y',
		update_user_id = 'CDM-25189',
		update_ts = now()
where 	removal_id = 254617
		and eligibility_status_cd = '2909'
		and delete_sw  = 'N' ;	
