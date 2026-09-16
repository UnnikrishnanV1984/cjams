/*
  
  
   Issue Description: CJAMS-65089
   Category/ Module  : Child removal tab
   Root cause:We have an updated from the user that the child removal & OOH program end date need
    to be updated to 05/18/2011 as the user has been edited the exit placement date to 05/18/2011.
   Pull request# for code fix:
   Reason why no related code fix: 
    requested a data fix to resolve
*/



update intakeservreqchildremoval 
set exitdate ='2011-05-18 18:34:36', updatedby = 'CJAMS-65089', updatedon = now() 
where intakeservreqchildremovalid = 'ae1f3987-5c24-4e3c-912e-dec019a74144' and activeflag = 1;

update personprogramarea
set enddate ='2011-05-18 18:34:36', updatedby = 'CJAMS-65089', updatedon = now() 
where personprogramid = '8aa788f3-129a-4c98-9c58-cbb8fd2b34cf' and activeflag = 1;

update tb_client_eligibility 
set end_dt ='2011-05-18 18:34:36', update_user_id = 'CJAMS-65089', update_ts = now()  
where removal_id =128794 and delete_sw = 'N' ;
