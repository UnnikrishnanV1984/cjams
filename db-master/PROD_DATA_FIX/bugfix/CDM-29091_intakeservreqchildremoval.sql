/*
   Issue Description: CDM-29091
   Category/ Module  : Child Removal 
   Root cause: child removed from CPS IR should show service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval
set servicecaseid = '4761fd7b-5359-4c9f-8301-41b60cda76b5', updatedby = 'CDM-29091', updatedon = now()
where intakeserviceid = '3e6eb2c9-f685-4551-b502-9fc0a072dfb5' and servicecaseid is null;

UPDATE cjams.intakeservicerequestactor
SET servicecaseid='4761fd7b-5359-4c9f-8301-41b60cda76b5', updatedby='CDM-29091', updatedon=now() 
WHERE intakeservicerequestactorid='69d2251b-43d8-4c27-aa21-3d08cac723f3' and intakeserviceid='3e6eb2c9-f685-4551-b502-9fc0a072dfb5';


