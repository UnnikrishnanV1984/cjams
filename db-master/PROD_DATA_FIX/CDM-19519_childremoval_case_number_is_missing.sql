/*
   Issue Description: CDM-19519
   Category/ Module  : Child removal  
   Root cause: Case number is missing from child removal history
   Pull request# for code fix: 4574
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update Intakeservreqchildremoval set servicecaseid = 'c8648a0b-149e-4346-be10-802468bb15e0', updatedby = 'CDM-19519', updatedon = now() where intakeservreqchildremovalid = 'af58b66e-290c-4074-899e-76e1f5b38088' and activeflag = 1;