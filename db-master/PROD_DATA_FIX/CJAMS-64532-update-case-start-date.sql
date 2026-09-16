/*
Issue: CJAMS-64532 Clock showing case is overdue when it is NOT
Category/Module: CPS IR Case Dashboard
Root cause: 261023457647  CPS IR case start is showing incorrectly and we need a data fix to update the case start date as 01/12/2026 05:08 PM
            We are unable to replicate this issue in stage-3 and we will monitor it for future occurences
Fix provided:  Data fix has been done to update the CPS-IR 261023457647 start date as 01/12/2026 05:08 PM
Data/Code fix ticket#: CJAMS-64532
Regression Impacts: N/A
Is Code fix Required?: TBD
Code fix ticket#: N/A
Reason why no related code fix: We are unable to replicate this issue in stage-3 and we will monitor it for future occurences
*/

update intakeservicerequest
set reporteddate = '2026-01-12 17:08:47.560',
    updatedby = 'CJAMS-64532',
    updatedon = now()
where intakenumber = 'I261013685839' 
and intakeserviceid = '31843738-30a8-41a4-b73d-b5e476a4f138' 
and activeflag =1;