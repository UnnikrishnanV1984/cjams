/*
   Issue Description: CDM-20260
   Category/ Module  : Child Removal history
   Root cause: user wants to remove draft record.
   Pull request# for code fix: 4769
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservreqchildremoval 
set activeflag = 0, updatedby = 'CDM-20260', updatedon = now()
where intakeservreqchildremovalid = 'adc4beac-edb2-46a4-8363-4f0424ebf0c1';