/*
   Issue Description: CJAMS-58522
   Category/ Module  : Child removal end date
   Root cause: user wants to remove child removal end date 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2025-02-20 12:45:00	ADNRE
UPDATE cjams.intakeservreqchildremoval
SET exitdate=null, removalexitreason=null, updatedby='CJAMS-58522', updatedon=null, returntransts=null
WHERE intakeservreqchildremovalid='896de6bf-de44-4786-a498-bae41c73615f' and personid='b1e436f8-8015-447d-99de-e087eacd31a6';

UPDATE personprogramarea 
SET enddate = null, updatedby = 'CJAMS-58522', updatedon = now() 
WHERE personprogramid = '493c6ad2-4231-4413-8907-04a4e1fc35e6' and personid='b1e436f8-8015-447d-99de-e087eacd31a6';

update tb_client_eligibility
set end_dt = null, update_user_id = 'CJAMS-58522', update_ts = now()
where removal_id = 255446;
