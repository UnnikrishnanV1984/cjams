/*
   Issue Description: CDM-38049
   Category/ Module  : CASE CLOSURE ISSUE
   Root cause: SAFE-C assessment has been created and all (5) children have been included into the SAFE-C assessment.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update assessmentactor 
set 
intakeservicerequestactorid='396e0858-bf5b-46d2-ac22-823984a16302',
updatedon = now(), 
updatedby = 'CDM-38049'
where 
assessmentactorid='2689075d-6435-440c-99c4-07d5dd4ec59d' and intakeservicerequestactorid = '4da47a84-fab7-447d-a72b-0e587e3faabe'
and activeflag=1;