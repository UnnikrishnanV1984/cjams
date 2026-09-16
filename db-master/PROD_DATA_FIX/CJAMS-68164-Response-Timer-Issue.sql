/*

Issue Description: CJAMS-68164
   Category/ Module  : Response Timer
   Root cause: Need to update CPS IR case start date and time as addendum to narrative 06/02/2026 9:40 AM and update response timer due date to 6/7/26 time as 9.40 am, if the response timer stop prior to the response timer due date , over due button should not be available. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix

*/


update intakeservicerequest 
set reporteddate = '2026-06-02 09:40:00',updatedby = 'CJAMS-68164', updatedon = now()
where servicerequestnumber = '261023814309' and activeflag = 1;


UPDATE intakesnapshot 
SET jsondata = jsonb_set(
    jsondata,
    '{General,narrativeUpdatedDate}',
     '"2026-06-02T13:40:52.721Z"',
    true
),
updatedon = now(),
updatedby = 'CJAMS-68164'
WHERE intakenumber = 'I261014087494' and activeflag=1;


update cjams.cpsresponsetimeractions
    set activeflag = 0, 
        updatedby = 'CJAMS-68164',
        updatedon = now()
where intakeserviceid  = '7412ff2a-ec91-49ed-80dc-d6f7de2a13ef'    and activeflag = 1;
