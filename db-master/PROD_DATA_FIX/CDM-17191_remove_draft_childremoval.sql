/*
    Issue Description: CDM-17191
    Category/Module  : Removal error
    Root cause: user wants to remove
    Pull request# for code fix: 
    Explanantion: user wants to remove the child removal
*/
update intakeservreqchildremoval
set activeflag = 0, updatedby = 'CDM-17191', updatedon = now() 
where intakeservreqchildremovalid = 'cf8d43e1-87a3-48d5-8dad-dbd5348ce650';