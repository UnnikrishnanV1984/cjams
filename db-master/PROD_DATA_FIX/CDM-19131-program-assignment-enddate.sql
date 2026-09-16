/*
 Issue Description:CDM-19131
 Category/ Module:program assignment enddate
 Root cause: update
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update personprogramarea set enddate=null,updatedon=now(),updatedby='CDM-19131'where personprogramid='6bc1b5d8-8c01-446e-8e5a-a1a0c48fd6c0';