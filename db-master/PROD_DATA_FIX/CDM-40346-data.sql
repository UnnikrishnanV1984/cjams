/*
  Issue Description: CDM-40346
   Category/ Module  :  Assignments
   Root cause: routed flag was not set to true which is used to fetch the assigned cases list
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE cjams.intakeservicerequest
SET  updatedby='CDM-40346', updatedon=now(), isrouted=true
WHERE intakeserviceid='26e48d3c-2d28-405b-ae1b-1168dfeeaea0' and servicerequestnumber='241022191843';