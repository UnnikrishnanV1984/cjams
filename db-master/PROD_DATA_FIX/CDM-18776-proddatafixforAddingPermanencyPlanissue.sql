
/*
   Issue Description: CDM-18776
   Category/ Module  : Wrong Removal ID and intakeserviceRequest actor ID in placement table
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--d38b4f28-2218-47e7-b6f0-42ded1ab64f1, eecd5fa7-564a-467b-b244-ada21c1ea6e4
update placement set intakeservicerequestactorid = '72e2fe05-9818-4cf3-971f-de88d6ccf0a5', intakeservreqchildremovalid = 'dc0611ce-912c-42d4-8774-a7c542e07e4f', updatedon= now(), updatedby = 'CDM-18776' where placementid = 'dc77e33a-893f-487f-a601-1965f3f51f2c';
