/*
   Issue Description: CJAMS-59188
   Category/ Module  : Assignments
   Root cause: update legislative reporting to reflect "Alleged victim unavailable; attempted face-to-face, 1-2 attempts.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V34F',
    updatedby ='CJAMS-59188',
    updatedon =now()
where intakeserviceid = 'd706ab06-d389-47c5-854e-790f9b2f7191'
and cpsresponsetimeractionsid = 'dfc6ed5e-8e8d-41b4-ad37-76cbf381ac71'
and activeflag = 1;