/*
   Issue Description: CDM-20259
   Category/ Module  : Child Removal History
   Root cause: user wants to remove draft record in child removal history 
   Pull request# for code fix: 4768
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
	
update intakeservreqchildremoval 
set activeflag = 0, updatedby = 'CDM-20259', updatedon = now()
where intakeservreqchildremovalid = 'a4f68acc-b7ad-42a9-a664-6a965969e14e';