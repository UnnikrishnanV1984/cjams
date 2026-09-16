/*
   Issue Description: CJAMS-59126
   Category/ Module  : Assignments
   Root cause: update legislative reporting to reflect "Alleged victim unavailable; attempted face-to-face, 1-2 attempts.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    updatedby ='CJAMS-59126',
    updatedon =now()
where intakeserviceid = 'f346c4b1-f65a-4df4-b8fb-9e8a90f22176'
and cpsresponsetimeractionsid = 'fe915b93-d4a6-4309-81e8-7198bfe594bb'
and activeflag = 1;