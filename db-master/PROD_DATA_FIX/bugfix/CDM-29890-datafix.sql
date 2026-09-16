/*
   Issue Description: CDM-29890
   Category/ Module  : Child removal end date
   Root cause: user wants to remove child removal end date for payment corrections 
   Pull request# for code fix: 6543
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set exitdate = null , 
updatedby = 'CDM-29890', updatedon  = now() where intakeservreqchildremovalid = 'd7c80be5-f66d-4c7d-8521-b9f72264c1d5';


update personprogramarea SET enddate = null,  updatedby = 'CDM-29890', updatedon = now()
where personprogramid='4141e7c4-5579-4a7e-978a-65dd8b55d1ca';

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CDM-29890',
    update_ts = now()
where removal_id = 187034;