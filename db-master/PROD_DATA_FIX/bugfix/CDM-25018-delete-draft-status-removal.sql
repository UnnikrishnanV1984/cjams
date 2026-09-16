/*
   Issue Description: CDM-25018
   Category/ Module  : draft status removal
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  user asked tp remove the clid removal record
*/

update intakeservreqchildremoval
	set activeflag = 0, updatedby = 'CDM-25018', updatedon = now() 
	where intakeservreqchildremovalid = '18e8401f-6875-4b75-985f-4368abfb1656';
