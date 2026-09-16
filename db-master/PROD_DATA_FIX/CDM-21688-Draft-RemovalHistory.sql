/*
   Issue Description: CDM-21688
   Category/ Module  : Child Removal
   Root cause: user wants to remove draft record in removal history
   Pull request# for code fix: 6729
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservreqchildremoval 
set activeflag = 0, updatedby = 'CDM-26188', updatedon = now()
where intakeservreqchildremovalid = '3a6e2d9f-4ef2-4495-a63c-eb3c074887ee';