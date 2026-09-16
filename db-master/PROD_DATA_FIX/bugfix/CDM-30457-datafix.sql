/*
   Issue Description: CDM-30457
   Category/ Module  : Child Removal end date removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set exitdate = null , 
updatedby = 'CDM-30457', updatedon  = now() 
where intakeservreqchildremovalid = '821b72ee-02e8-44cb-bd21-8c4fb05195ba';


update personprogramarea SET enddate = null,  updatedby = 'CDM-30457', updatedon = now()
where personprogramid='6ad27132-719b-4dca-a8e2-aa5caee91333';

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CDM-30457',
    update_ts = now()
where removal_id = 197644;
