/*
   Issue Description: CDM-16986
   Category/ Module  : drat removal
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  user asked tp remove the clid removal record
*/

update intakeservreqchildremoval
	set activeflag = 0, updatedby = 'CDM-15023', updatedon = now() 
	where intakeservreqchildremovalid = '8eef247f-aa3c-4513-a394-965065de6ef7';