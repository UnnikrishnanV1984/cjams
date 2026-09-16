-- CDM-32585 - Removal end date error
/*
-- Issue Description: 
   User reuest to re-open Child Removal / OOH   

-- Case ID: 221030015626
-- Client ID: 4091101 (AKIRA AKERS ANN KEEGAN) - c74f6b53-d49b-45c9-8eff-0813792331b1
-- Child Removal ID: 253894 - 2022-04-21 To 2023-06-16 - 65e42b3b-d6df-4b72-b231-51661eef4aee
-- OOH - 2022-04-21 To 2023-06-16 - 151e35c3-e2b1-4f84-b2b8-bc5e875d8f37

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to re-open the Child Removal / OOH   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Child Removal, OOH & IV-E
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 253894
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-32585',
	updatedon = now()
where removalid = 253894
	and activeflag = 1;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '151e35c3-e2b1-4f84-b2b8-bc5e875d8f37'
	and activeflag = 1;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-32585',
	updatedon = now()
where personprogramid = '151e35c3-e2b1-4f84-b2b8-bc5e875d8f37'
	and activeflag = 1;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 253894
	and delete_sw = 'N';

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-32585',
	update_ts = now()
where removal_id = 253894
	and delete_sw = 'N';

