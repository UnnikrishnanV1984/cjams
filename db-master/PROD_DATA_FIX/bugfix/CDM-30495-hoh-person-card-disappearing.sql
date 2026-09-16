
 /*  Issue Description: CDM-30495-hoh-person-card
   Category/ Module  :  service case
   Root cause: 
   Pull request# for code fix: N/A.
   Reason why no related code fix: N/A.
   Status of the code fix if already submitted and expected prod fix date: N/A 

*/

update intakeservicerequestactor 
set isprimary  = true ,updatedby='CDM-30495', updatedon=now()
where intakeservicerequestactorid = '09392a0c-49ab-48cb-84b2-bbac0fa71b0a';