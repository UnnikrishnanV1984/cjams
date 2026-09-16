/*
   Issue Description: CDM-18967
   Category/ Module  : Child removal history 
   Root cause: User requested to remove child removal history
   Pull request# for code fix: 4351
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval
set activeflag = 0, updatedby = 'CDM-18967', updatedon = now() 
where intakeservreqchildremovalid = '66688859-1e00-47e1-b262-e4522349735e';