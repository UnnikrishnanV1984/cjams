-- CDM-17792 - Duplicate Removals
/*
-- Issue Description: 
    User request to delete the Duplicate Child Removal & OOH.  
    
-- Case ID: 3304128
-- Client ID: 4224802 (ASHTON ODOM) - 20074c49-e0d7-4dd7-a931-c6992bade683
-- Removal IDs
-- 197920 - 2019-11-15 To 2021-06-29 - c9166b6c-b55a-44f3-8a2f-46a572d807d6 (CHESSIE Approved)
-- 252319 - 2019-11-19 To 2021-06-30 - d365b877-9137-48a8-bd51-f9c9ac23acf9 (CJAMS Approved) -- Delete 

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placementtypekey, alternateid, altproviderid, isvoided, startdatetime, enddatetime,
	intakeservreqchildremovalid, updatedby, updatedon 
from placement  
where personid = '20074c49-e0d7-4dd7-a931-c6992bade683'
	and intakeservreqchildremovalid = 'd365b877-9137-48a8-bd51-f9c9ac23acf9' -- 2 LA 
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid = NULL,
	updatedby = 'CDM-17792',
	updatedon = now()
where personid = '20074c49-e0d7-4dd7-a931-c6992bade683'
	and intakeservreqchildremovalid = 'd365b877-9137-48a8-bd51-f9c9ac23acf9' -- 2 LA 
	and activeflag = 1 ;
	
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252319
	and rm.personid = '20074c49-e0d7-4dd7-a931-c6992bade683' 
	and rm.activeflag = 1 ;
	
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-17792',
	rm.updatedon = now() 		
where rm.removalid = 252319
	and rm.personid = '20074c49-e0d7-4dd7-a931-c6992bade683' 
	and rm.activeflag = 1 ;

select * 
	from routing ro 
where ro.eventcode = 'CHRR'
	and ro.objectid = 'd365b877-9137-48a8-bd51-f9c9ac23acf9'
	and ro.activeflag = 1 ;
		
update routing ro
set activeflag = 0,
	updatedby = 'CDM-17792',
	updatedon = now()
where ro.eventcode = 'CHRR'
	and ro.objectid = 'd365b877-9137-48a8-bd51-f9c9ac23acf9'
	and ro.activeflag = 1 ;

select programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personid = '20074c49-e0d7-4dd7-a931-c6992bade683'
	and personprogramid  = 'b728e6e0-eba0-41f4-8a90-a2605b86215d'
	and programkey = 'OOH'
	and enddate is null
	and activeflag = 1 	;
	
update personprogramarea
set activeflag = 0,
	enddate = '2021-06-30 00:00:00',
	updatedby = 'CDM-17792',
	updatedon = now()
where personid = '20074c49-e0d7-4dd7-a931-c6992bade683'
	and personprogramid  = 'b728e6e0-eba0-41f4-8a90-a2605b86215d'
	and programkey = 'OOH'
	and enddate is null
	and activeflag = 1 ;
	
select eligibility_id, client_id, case_id, eligibility_status_cd, update_ts, update_user_id, delete_sw 
	from tb_client_eligibility 
where removal_id = 252319
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;	

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-17792',
	update_ts = now()
where removal_id = 252319
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;	

