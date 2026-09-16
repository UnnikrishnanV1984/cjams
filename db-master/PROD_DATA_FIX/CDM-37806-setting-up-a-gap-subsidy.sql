-- CDM-37806
/*
-- Root cause: Unable to set up the GAP subsidy for case # 211030012301. The case closed in OOH in January but the GAP was not set up correctly. Provider is not getting payment.
-- Fix Provided: Datafix has been done to remove the End Date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Backup
select intakeservreqchildremovalid,returntransts,exitdate,updatedon,updatedby from cjams.intakeservreqchildremoval where 
servicecaseid='130433bf-0a63-44b7-b730-eb75d8f299bc' and removalid=266075;
--UPDATE cjams.intakeservreqchildremoval
--SET exitdate='2024-01-19 10:10:00.000', returndate=NULL, returntime=NULL, removalexitreason='GUARDR', returntransts='2024-02-22', updatedon='2024-02-22 15:24:56.690', updatedby='519e895e-17f5-410d-b0a5-ec588a03c362'
--WHERE intakeservreqchildremovalid='8263da8a-609c-4dc1-8982-dae9fd43c1af';

-- Update
UPDATE cjams.intakeservreqchildremoval
SET exitdate = null,returntransts = null,updatedby = 'CDM-37806',updatedon = now()
WHERE intakeservreqchildremovalid='8263da8a-609c-4dc1-8982-dae9fd43c1af' and removalid=266075 and activeflag = 1;

-- Backup
select programkey, startdate, enddate, updatedby, updatedon from cjams.personprogramarea where 
personprogramid='f26ccd1f-9db8-4891-bd0b-64d315e26bb0' and activeflag = 1;
--UPDATE cjams.personprogramarea
--SET programkey='OOH', startdate='2023-03-08 00:00:00.000', enddate='2024-01-19 00:00:00.000', updatedby='519e895e-17f5-410d-b0a5-ec588a03c362', updatedon='2024-02-22 15:24:05.704'
--WHERE personprogramid='f26ccd1f-9db8-4891-bd0b-64d315e26bb0' and activeflag = 1;

-- Update
update cjams.personprogramarea 
set enddate = null, 
	updatedby = 'CDM-37806',
	updatedon = now()
where  personprogramid='f26ccd1f-9db8-4891-bd0b-64d315e26bb0' and activeflag = 1;

-- Backup
select end_dt,update_user_id,update_ts,removal_id from cjams.tb_client_eligibility where removal_id=266075 and delete_sw = 'N';
--UPDATE cjams.tb_client_eligibility
--SET end_dt='2024-01-19', update_user_id='7bd14780-079c-4d7a-8fa3-6df4eff1dfb8', update_ts='2024-02-22 15:24:56.690', removal_id=266075
--WHERE removal_id=266075 and delete_sw = 'N';

-- Update
update cjams.tb_client_eligibility
set  end_dt = null,
	update_user_id = 'CDM-37806',
	update_ts = now()
where  removal_id=266075 and delete_sw = 'N';