/*
   Issue Description: CJAMS-59721
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
    updatedby ='CJAMS-59721',
    updatedon =now()
where intakeserviceid = '274e24fb-8ffc-48df-a024-628cf6d0a717'
and cpsresponsetimeractionsid = '4c0de533-a151-4600-b1a1-25dc3e405e18'
and activeflag = 1;