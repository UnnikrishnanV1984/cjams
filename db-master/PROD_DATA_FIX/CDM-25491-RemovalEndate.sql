/*
   Issue Description: CDM-25491
   Category/ Module  : Child removal end date
   Root cause: user wants to remove child removal end date for payment corrections 
   Pull request# for code fix: 6543
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakeservreqchildremoval 
SET exitdate=null,  
    updatedby='CDM-25491',
    updatedon=now() 
WHERE intakeservreqchildremovalid = '34a66973-638a-4fd0-b598-b57bfa584c81';

UPDATE personprogramarea 
SET enddate = null, 
    updatedby = 'CDM-25491', 
    updatedon = now() 
WHERE personprogramid = '365b93fc-acdc-4e7d-83f9-9e75289589e7';

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CDM-25491',
    update_ts = now()
where removal_id = 185160;