/*
   Issue Description: CDM-32757
   Category/ Module  : Child Removal 
   Root cause: User error
   Fx Provided:  Removed draft record as per request 
*/

update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-32757', updatedon = now()
where intakeservreqchildremovalid ='ed55fe02-7cd6-4f86-b41e-4d342d711978';

update cjams.intakeservreqchildremoval_history set activeflag =0, updatedby ='CDM-32757', updatedon = now()
where intakeservreqchildremovalid ='ed55fe02-7cd6-4f86-b41e-4d342d711978';