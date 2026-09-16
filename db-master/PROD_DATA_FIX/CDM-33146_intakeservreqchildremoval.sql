/*
   Issue Description: CDM-33146
   Category/ Module  : Child removal end date
   Root cause: user wants to remove child removal end date to enter placement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE cjams.intakeservreqchildremoval
SET exitdate=null, removalexitreason=null, updatedby='CDM-33146', updatedon=null, returntransts=null
WHERE intakeservreqchildremovalid='1b29d08f-dd38-4368-97de-716a9ff9807a' and personid='e624eb40-2abc-4312-add8-354e9b7ba2ea';

UPDATE personprogramarea 
SET enddate = null, updatedby = 'CDM-33146', updatedon = now() 
WHERE personprogramid = '58d2502f-f160-4c8a-8ebe-cfa42c63709d' and personid='e624eb40-2abc-4312-add8-354e9b7ba2ea';

update tb_client_eligibility
set end_dt = null, update_user_id = 'CDM-33146', update_ts = now()
where removal_id = 253847;
