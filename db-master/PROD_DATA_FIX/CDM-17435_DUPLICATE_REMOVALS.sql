/*
  Issue Description: CDM-17435
   Category/ Module  :  duplicate removals
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval
	set activeflag = 0, updatedby = 'CDM-17435', updatedon = now() 
	where intakeservreqchildremovalid = '0be94123-e671-411f-aa65-cd56266f101e';