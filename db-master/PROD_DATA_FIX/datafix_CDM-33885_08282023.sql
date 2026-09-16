-- CDM-33885 - removal end-dated in error
/*
-- Issue Description: 
   User reuest to re-open Child Removal / OOH   

-- Case ID: 3278443
-- Client ID: 4109342 (RYAN	RASHEED	BRIDGEMAN) - 1dacff63-8563-49c7-b24e-ccf3d0322cb1
-- Child Removal ID: 283179 - 2023-08-09 To 2023-08-10 - fd60db0e-ee93-4209-b179-6d95c479a69c
-- OOH - 2023-08-09 To 2023-08-10 - 12f64ace-d095-471d-8f90-b0eecfd3c97b

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to re-open the Child Removal / OOH   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Child Removal, OOH & IV-E and update Placement exit Type (CDM-33885)
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 283179
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-33885',
	updatedon = now()
where removalid = 283179
	and activeflag = 1;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '12f64ace-d095-471d-8f90-b0eecfd3c97b'
	and activeflag = 1;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-33885',
	updatedon = now()
where personprogramid = '12f64ace-d095-471d-8f90-b0eecfd3c97b'
	and activeflag = 1;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 283179
	and delete_sw = 'N';

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-33885',
	update_ts = now()
where removal_id = 283179
	and delete_sw = 'N';

-- Update Placement
select alternateid,
	exitreasontypekey, -- REUNIF
	exittypekey, -- PLCC
	exittypetypekey, -- NULL
	leastrestrictiveplacement,  -- Direct order shelter care to Krisly A Trestrail, who Mekhi's father. Mekhi is Ryan's brother. 
	remarks, -- Direct order shelter care to Krisly A Trestrail, who Mekhi's father. Mekhi is Ryan's brother.
	updatedby, -- '45391f16-58de-4b24-bd7e-12cdc4ff4335'
	updatedon -- '2023-08-19 09:32:45.588'
from placement 
where alternateid = 1715964
	and activeflag = 1 ;
	
update placement
set exitreasontypekey = null,
	exittypekey = 'CIPS', -- Change in Placement Structure
	remarks = 'Removal was end-dated in error therefore this placement was closed and correct placement was entered.',
	updatedby = 'CDM-33885',
	updatedon = now()
where alternateid = 1715964
	and activeflag = 1 ;	
