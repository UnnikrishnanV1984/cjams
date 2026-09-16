/*
   Issue Description: CDM-32350
   Category/ Module  :Dashboard
   Root cause:User wants to delete cps repone timer pending approval as the overdue has been approved by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/


update
  routing
set activeflag =0 ,
  updatedby = 'CDM-32350',
  updatedon =now()
where 
  routingid in('3d6f399c-a356-449f-bfc2-77839fb0862c','5fa203ca-6ef3-481b-bbaf-68393c555c24');