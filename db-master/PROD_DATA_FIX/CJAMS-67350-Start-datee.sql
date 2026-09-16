

/*
   Issue Description: CJAMS-67350
   Case# 261030676144 -Need technical investigation from where the case start date of 04/16/2026 7:55 PM come from, and please proceed with the data fix to update the case start date to 03/27/2026 3:29 PM
   Category/ Module  : Service Case
   Root cause: User requested to change case start date . 
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/


update servicecase 
set startdate ='2026-03-27 15:29:00',effectivedate ='2026-03-27 15:29:00',insertedon ='2026-03-27 15:29:00',updatedby = 'CJAMS-67350',updatedon =now() 
where servicecaseid ='0212ab40-2411-4730-9a9d-4bfe322d3fee' and activeflag =1;

update servicecasedisposition 
set statusdate ='2026-03-27 15:29:00',effectivedate ='2026-03-27 15:29:00',insertedon ='2026-03-27 15:29:00',updatedby = 'CJAMS-67350',updatedon =now() 
where servicecaseid ='0212ab40-2411-4730-9a9d-4bfe322d3fee' and activeflag =1;
