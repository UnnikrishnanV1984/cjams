/*
   Issue Description: CJAMS-59088
   Category/ Module  : Assignments
   Root cause: CPS AR # 251023010462 is still open and the late report has been approved on 04/01/2025.
   As per system design, the late report can not be edited and saved once it is approved.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    cpsresponsetimerreason7 = 'CCCN',
    cpsresponsetimerreason8 = 'CFFN',
    cpsresponsetimerreason9 = 'C12F',
    updatedby ='CJAMS-59088',
    updatedon =now()
where intakeserviceid = 'a9b0ca65-37ca-48e8-a3f5-465de0cd68a4'
and cpsresponsetimeractionsid = '0963da3f-3a41-4bf0-b8a5-8310371b1a07'
and activeflag = 1;
