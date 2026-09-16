/*
   Issue Description: CDM-20261
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to remove draft record. 
   Pull request# for code fix: 4771
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
	
update intakeservreqchildremoval 
set activeflag = 0, updatedby = 'CDM-20261', updatedon = now()
where intakeservreqchildremovalid = '4fb309fd-0c78-4933-bafd-c59b660d898d';
