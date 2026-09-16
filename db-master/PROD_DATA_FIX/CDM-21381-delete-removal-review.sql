/*
   Issue Description: CDM-21381
   Category/ Module  : Delete removal review   
   Root cause: Possible duplicate
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
set activeflag  = 0, updatedby = 'CDM-21381', updatedon = now() 
where objectid = '153047a5-9b92-4dad-b6ce-d9bebb919df5';

update intakeservreqchildremoval
set activeflag = 0, updatedby = 'CDM-21381', updatedon = now()
where removalid = '253686';
