/* 
    Issue Description: CDM-20205
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to delete duplicate case in removal history. 
   Pull request# for code fix: 4764
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-20205', updatedon = now()
where intakeservreqchildremovalid = 'aa926c0f-f6a2-4e62-8ae6-309da768bdb6';