/*
   Issue Description: CDM-29010
   Category/ Module  : Child Removal  
   Root cause: User requested to update the child removal end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    intakeservreqchildremoval
set
    exitdate = '02/23/2023',
    updatedby = 'CDM-29010',
    updatedon = now()
where
    intakeservreqchildremovalid = '7c377d44-00a2-4436-b3ca-72166544ef49';

update tb_client_eligibility set end_dt  = '2023-02-23', update_user_id = 'CDM-29010', update_ts = now() 
where removal_id = '186930';

update personprogramarea set enddate = '2023-02-23 00:00:00.000', 
updatedby = 'CDM-29010', updatedon = now()  where personprogramid = '731d6cc7-66d5-4a61-80a1-949ce393910c';