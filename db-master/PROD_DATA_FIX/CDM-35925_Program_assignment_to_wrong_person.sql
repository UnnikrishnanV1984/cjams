/*
 Issue Description: CDM-35925
 Category/ Module  : Program Assignment
 Root cause: Deceased client was given a program assignement
 Fix: Deleting the record from personprogramarea
 Pull request# for code fix:
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
update
    personprogramarea
set
    activeflag = 0,
    updatedby = 'CDM-35925',
    updatedon = now()
where
    personprogramid = '7e816398-fa0d-49e7-bb70-339c48129ec7';