/*
   Issue Description: CDM-25974
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to remove end date and placement 
   Pull request# for code fix: 5821
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update cjams.personprogramarea set enddate= null, updatedby='CDM-25974', updatedon=now()
where personprogramid ='3e9dfd59-1eb0-4423-8d73-12d093c3b78b';

update cjams.intakeservreqchildremoval set exitdate = null, updatedby='CDM-25974', updatedon=now()
where intakeservreqchildremovalid='941847cf-19c1-43dc-ac6d-8013a3649e0f';


update tb_client_eligibility set end_dt = null,update_ts = now(), update_user_id = 'CDM-25974' where removal_id =251062; 
