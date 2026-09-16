-- CDM-26320 - Existing Provider not Populating
/*
-- Issue Description: 
   User reuest to re-open the Placement / Child Removal / OOH   

-- Case ID: 3273091
-- Provider ID: 6005928 (Melinda Mattison) - Local Department Home

-- Client ID: 200018324 (AMARII Cathrine HAYES) - 5f18d61c-67f6-479a-8a2d-7d87cb0bb044
-- 1572176 - 2022-04-14 To 2022-10-26 - 25e95677-e1b4-4eaa-8042-c10c22a40298
-- Removal ID: 250722
-- OOH	460fbe88-5041-493f-8c8e-633cd82052d7

-- Client ID: 4035152 (KYANI Faith HAYES) - d5af37c6-4114-40d4-ae74-d3f0418438fe
-- 1572177	2022-04-14 00:00:00	2022-10-26 00:00:00	b7fa3fc1-3034-40e0-95c1-4f1d28fc4dc5
-- Removal ID: 250503
-- OOH	1410e72c-18be-49c4-8503-641960d4eba8
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Placement, Removal, OOH & IV-E

-- Client ID: 200018324 (AMARII Cathrine HAYES) - 5f18d61c-67f6-479a-8a2d-7d87cb0bb044
-- 1572176 - 2022-04-14 To 2022-10-26 - 25e95677-e1b4-4eaa-8042-c10c22a40298
-- Removal ID: 250722
-- OOH	460fbe88-5041-493f-8c8e-633cd82052d7

-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '25e95677-e1b4-4eaa-8042-c10c22a40298'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-26320'
where placementid = '25e95677-e1b4-4eaa-8042-c10c22a40298'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '25e95677-e1b4-4eaa-8042-c10c22a40298'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-26320'
where placementid = '25e95677-e1b4-4eaa-8042-c10c22a40298'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 250722
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-26320',
	updatedon = now()
where removalid = 250722
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '460fbe88-5041-493f-8c8e-633cd82052d7'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-26320',
	updatedon = now()
where personprogramid = '460fbe88-5041-493f-8c8e-633cd82052d7'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  250722
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-26320',
	update_ts = now()
where removal_id =  250722
	and delete_sw = 'N' ;
	

-- Client ID: 4035152 (KYANI Faith HAYES) - d5af37c6-4114-40d4-ae74-d3f0418438fe
-- 1572177	2022-04-14 00:00:00	2022-10-26 00:00:00	b7fa3fc1-3034-40e0-95c1-4f1d28fc4dc5
-- Removal ID: 250503
-- OOH	1410e72c-18be-49c4-8503-641960d4eba8

-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = 'b7fa3fc1-3034-40e0-95c1-4f1d28fc4dc5'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-26320'
where placementid = 'b7fa3fc1-3034-40e0-95c1-4f1d28fc4dc5'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'b7fa3fc1-3034-40e0-95c1-4f1d28fc4dc5'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-26320'
where placementid = 'b7fa3fc1-3034-40e0-95c1-4f1d28fc4dc5'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 250503
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-26320',
	updatedon = now()
where removalid = 250503
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '1410e72c-18be-49c4-8503-641960d4eba8'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-26320',
	updatedon = now()
where personprogramid = '1410e72c-18be-49c4-8503-641960d4eba8'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  250503
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-26320',
	update_ts = now()
where removal_id =  250503
	and delete_sw = 'N' ;
	
-- Update Provider Vacancy
select provider_id, vacancy_no, update_ts, update_user_id
	from prov.tb_provider
where provider_id = 6005928
	and delete_sw = 'N' ;

update prov.tb_provider
set vacancy_no = vacancy_no - 2,
	update_ts = now(),
	update_user_id = 'CDM-26320'
where provider_id = 6005928
	and delete_sw = 'N' ;

