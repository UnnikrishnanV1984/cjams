/*
   Issue Description: CDM-20116
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to remove case from child removal history.
   Pull request# for code fix: 4745
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservreqchildremoval 
set activeflag = 0, updatedby = 'CDM-20116', updatedon = now()
where intakeservreqchildremovalid = 'fae4a4f6-15e9-4fbd-bb0c-4bda610c37e8';