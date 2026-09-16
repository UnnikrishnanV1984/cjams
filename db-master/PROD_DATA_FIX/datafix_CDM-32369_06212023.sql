-- CDM-32369 - End date removal
/*
-- Issue Description: 
   User reuest to re-open Child Removal / OOH   

-- Case ID: 3089037
-- Client ID: 1077678 (BROOKE WHISMAN) - 89c1e056-2353-4f6c-b931-47bcb01af3e5
-- Child Removal ID: 189257	 - 2018-02-15 To 2022-04-20 - 183d56c4-00e2-42f6-a741-197511fb11e9
-- OOH - 2018-02-15 To 2022-04-20 - 73967ec1-3263-4741-b7e6-826c94ef5758

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
where removalid = 189257
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-32369',
	updatedon = now()
where removalid = 189257
	and activeflag = 1;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '73967ec1-3263-4741-b7e6-826c94ef5758'
	and activeflag = 1;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-32369',
	updatedon = now()
where personprogramid = '73967ec1-3263-4741-b7e6-826c94ef5758'
	and activeflag = 1;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 189257
	and delete_sw = 'N';

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-32369',
	update_ts = now()
where removal_id = 189257
	and delete_sw = 'N';
