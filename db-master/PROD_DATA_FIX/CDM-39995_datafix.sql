/*
  Issue Description:  CDM-39995
   Category/ Module  :  Assignments
   Root cause: routed flag was not set to true which is used to fetch the assigned cases list
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE cjams.intakeservicerequest
SET  updatedby='CDM-39995', updatedon=now(), isrouted=true
WHERE intakeserviceid='ac4a2930-c642-4b51-ae75-048c24912eca' and servicerequestnumber='241022061516';