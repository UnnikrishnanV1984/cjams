/*
 Issue Description:CJAMS-57424
 Root cause: Need-case-opened
 Fix: Updating the servicecase disposition.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */

 update intakeservicerequest 
set servicecaseid = null,updatedby = 'CJAMS-57424',updatedon =now() 
where intakeserviceid ='98b93bd7-86f8-44ef-9aae-7e1a30b5228e' and activeflag=1;

update servicecasedisposition
set statusdate='2025-02-03 17:35:08', effectivedate='2025-02-03 17:35:08',updatedby = 'CJAMS-57424',updatedon =now() 
where servicecasedispositionid='0124f64f-7255-4ef9-b433-3ba6bb5dede1' and activeflag = 1;
