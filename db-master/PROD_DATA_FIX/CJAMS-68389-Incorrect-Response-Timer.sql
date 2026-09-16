/*

Issue Description: CJAMS-68389
   Category/ Module  : Response Timer
   Root cause: Need data fix to update the CPS-AR : 261023821087 start date to 06/11/2026 2:34 PM and response timer due date to to 6/16/26 2:34pm.

Note : This is know issue it will resolve as part of the CIDM-11278
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix

*/


update intakeservicerequest
set reporteddate = '2026-06-11 14:34:57',
updatedby = 'CJAMS-68389',
updatedon = now()
where intakeserviceid='ff013c0b-fc9a-413a-971f-fd9b7abdb9c4' and activeflag = 1;

update cjams.cpsresponsetimeractions
    set activeflag = 0, 
        updatedby = 'CJAMS-68389',
        updatedon = now()
where intakeserviceid  = 'ff013c0b-fc9a-413a-971f-fd9b7abdb9c4' and activeflag = 1;