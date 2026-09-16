/*
   Issue Description: CDM-17043
   Category/ Module  : drat removal
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  user asked tp remove the clid removal record
*/


update intakeservreqchildremoval
	set activeflag = 0, updatedby = 'CDM-17043', updatedon = now() 
	where intakeservreqchildremovalid = '722f7b4f-b42f-4192-b0c6-b980e6cdb095';