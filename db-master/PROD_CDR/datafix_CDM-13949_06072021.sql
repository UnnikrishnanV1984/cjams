-- CDM-13949 - Reopen legal custody
/*
-- Issue Description: 
   User error, Datafix request to re-open child Removal.
   
-- Case ID: 3262105 - rhonda.gardner@maryland.gov
-- Client ID: 3490656 (JASMINE ELIZABETH LUELLMAN)
    
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove Removal End date (Old value was 2021-06-04)
-- Update Removal, OOH & IV-E

-- Update Removal
select removaldate, exitdate, returndate, returntime, updatedby, updatedon  
	from cjams.intakeservreqchildremoval
where intakeservreqchildremovalid = '726ada3f-68f8-4dcd-abfd-2d35bb0852aa'
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	updatedby = 'CDM-13949',
	updatedon = now()
where intakeservreqchildremovalid = '726ada3f-68f8-4dcd-abfd-2d35bb0852aa'
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '94e6f31f-36db-4b73-aa51-39ac6ddcea1b'
	and activeflag = 1 ;


update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-13949',
	updatedon = now()
where personprogramid = '94e6f31f-36db-4b73-aa51-39ac6ddcea1b'
	and activeflag = 1 ;
	
-- Legal Custody
select fromdate, todate, updatedby, updatedon
	from legalcustody 
where legalcustodyid = '6a1383d3-3bd6-49be-b32f-e053b1c8bff6'
	and activeflag = 1;

update cjams.legalcustody 
set todate = Null, 
	updatedby = 'CDM-13949',
	updatedon = now()
where legalcustodyid = '6a1383d3-3bd6-49be-b32f-e053b1c8bff6'
	and activeflag = 1;
	
-- Update Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 158511
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-13949',
	update_ts = now()
where eligibility_id = 158511
	and delete_sw = 'N' ;
	
/*
select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id = 158511
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set end_dt = Null,
	update_user_id = 'CDM-13949',
	update_ts = now()
where eligibility_id = 158511
	and delete_sw = 'N' ;
*/

-- Placement 
select alternateid, exittypekey, exitreasontypekey, updatedby, updatedon 
	from placement  
where placementid = '36699a5b-adfc-4fbf-b827-6bd86f67b4d9'
	and activeflag  = 1 ;

update cjams.placement  
set exitreasontypekey = Null,
	exittypekey = 'CIPS', -- Change in Placement Structure
	updatedon = now(), 
	updatedby = 'CDM-13949'
where placementid = '36699a5b-adfc-4fbf-b827-6bd86f67b4d9'
	and activeflag  = 1 ;