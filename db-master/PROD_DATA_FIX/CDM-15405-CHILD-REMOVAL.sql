/*
   Issue Description: CDM-15405
   Category/ Module  :  Case worker  
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval
set updatedby = 'CDM-15405', updatedon = now(), activeflag = 0
where intakeservreqchildremovalid = 'ed0e07be-c1ec-45a9-a44d-a9b4ec6b30f7';

update placement
set updatedby = 'CDM-15405', updatedon = now(), activeflag = 0
where placementid = 'c099eed2-4fbc-4468-9105-b86ab084222e';