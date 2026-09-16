-- CDM-28512 - Ayotunde Ajayi and Olufemi Ajayie
/*
-- Issue Description: 
  211030011899:Void needs to removed and put back into placement for Allison Filzen.


-- Case ID: 211030011899 
-- Client ID: 475062817 (Olufemi Ajayie) - 74a1222e-4f0e-4718-82e0-c6d5cdc4b118
-- Client ID: 431061939 (Ayotunde Ajayi) - 56b9cd76-8eab-487c-aac6-b4bf0592aada
-- Removal ID: 253028 - 2021-10-27 To 2023-01-20 - 685f5af1-ee00-4cff-bf3b-dfae70a141df
-- Eligibility ID: 10003691
-- OOH: OOH	2021-10-27 To 2023-01-20 - 8933ddeb-d52f-436a-bae2-b9dc3b2a5822
-- OOH: OOH	2021-10-27 To 2023-01-20 - 3d4fb73c-05f0-4520-b38b-0491d7c185ed
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Removal, OOH & IV-E
-- Update Removal

-- Kid : Ayotunde Ajayi
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 253028
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-28512',
	updatedon = now()
where removalid = 253028
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '3d4fb73c-05f0-4520-b38b-0491d7c185ed'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-28512',
	updatedon = now()
where personprogramid = '3d4fb73c-05f0-4520-b38b-0491d7c185ed'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  253028
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-28512',
	update_ts = now()
where removal_id =  253028
	and delete_sw = 'N' ;

-- Kid : Olufemi Ajayie 

select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 253029
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-28512',
	updatedon = now()
where removalid = 253029
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '8933ddeb-d52f-436a-bae2-b9dc3b2a5822'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-28512',
	updatedon = now()
where personprogramid = '8933ddeb-d52f-436a-bae2-b9dc3b2a5822'
	and activeflag = 1 ;

	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  253029
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-28512',
	update_ts = now()
where removal_id =  253029
	and delete_sw = 'N' ;    


