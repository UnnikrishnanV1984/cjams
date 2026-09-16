/*
   Issue Description: CDM-28551
   Category/ Module  :  Draft entry delete
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	intakeservreqchildremoval 
set 	activeflag = 0,
		updatedby = 'CDM-28551',
		updatedon = now() 		
where 	
	   intakeservreqchildremovalid  = '56c107f1-1625-446c-b494-13cf712f9626' 
		and activeflag = 1;
