/*
   Issue Description: CDM-33774
   Category/ Module  :  
   Root cause: Removing Duplicate child removal
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

update intakeservreqchildremoval 
set updatedby = 'CDM-33774', updatedon = now(), activeflag = 0
where intakeservreqchildremovalid = '749c8757-08d7-405e-a7af-82f9c8c8e226';

update tb_client_eligibility 
set update_user_id = 'CDM-33774', update_ts = now(), delete_sw = 'Y'
where removal_id = 268735 and client_id = 200145604;

update personprogramarea set activeflag =0, updatedby ='CDM-33774', updatedon = now() 
where personid ='bc17b239-5fb4-4f88-9227-6eca688da96c' and programkey ='OOH' and enddate is null and 
personprogramid = 'd8c6144e-68a2-4773-b146-f2516b2041f4';
