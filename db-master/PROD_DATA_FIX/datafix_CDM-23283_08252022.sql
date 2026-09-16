-- CDM-23283 - CASE OF GABRIEL WESTON-NEEDS TO HAVE REMOVAL END DATE TAKEN OUT IN ORDER TO PUT PLACEMENT IN.
/*
-- Issue Description: 
   User reuest to re-open the Child Removal / OOH   

-- CAse ID: 3225302
-- Client ID: 3536798 (GABRIEL WILLIAM WESTON) - f25ba7a9-da68-4df6-bd27-99860758025f

-- Removal ID: 173543 - 2015-04-22 To 2016-07-12 - b801e519-b973-4468-9fbf-dc2471e46e5b
-- Eligibility ID: 150721
-- OOH: 2015-04-22 To 2016-07-12 - 2024d7e9-fa94-4b7a-8437-df189871dae8
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Removal, OOH & IV-E
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 173543
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-23283',
	updatedon = now()
where removalid = 173543
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '2024d7e9-fa94-4b7a-8437-df189871dae8'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-23283',
	updatedon = now()
where personprogramid = '2024d7e9-fa94-4b7a-8437-df189871dae8'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  173543
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-23283',
	update_ts = now()
where removal_id =  173543
	and delete_sw = 'N' ;
	
-- Eligibility Period is Active in this case
select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id =  150721
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set end_dt = Null,
	update_user_id = 'CDM-23283',
	update_ts = now()
where eligibility_id =  150721
	and delete_sw = 'N' ;
