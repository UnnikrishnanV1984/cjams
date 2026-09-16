/*
   Issue Description: CDM-39091
   Category/ Module  : Assign completed cases 
   Root cause: isrouted flag was set to false which was not pulling the record in the dashboard
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.intakeservicerequest
SET  updatedby='CDM-39091', updatedon=now(), isrouted=true
WHERE intakeserviceid='7210f9df-5276-4190-8b3c-588d73d7c23b' and servicerequestnumber='241021924098';
