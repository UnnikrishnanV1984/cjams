/* 
    Issue Description: CDM-38976
   Category/ Module  : child removal
   Root cause: user request to change the exit date for the child removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakeservreqchildremoval 
SET exitdate = '2024-04-04 16:00:00.000',    
    updatedby ='CDM-38976',
    updatedon = now()
WHERE intakeservreqchildremovalid = '0e67929e-b64f-4961-8e42-f5d4b8cdca30';

UPDATE personprogramarea 
SET enddate = '2024-04-04 16:00:00.000',    
    updatedby ='CDM-38976',
    updatedon = now()
WHERE personprogramid ='9143d50f-9701-48ac-8c08-b86552f54823'
and personid ='6681acb1-f433-4dfa-936f-4dca5bbeaa91';


UPDATE tb_client_eligibility 
SET end_dt = '2024-04-04 16:00:00.000',    
    update_user_id ='CDM-38976',
    update_ts = now()
WHERE removal_id = '159206';

