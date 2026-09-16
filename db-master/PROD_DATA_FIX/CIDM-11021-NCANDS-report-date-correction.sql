/*
Issue:CIDM-11021 NCANDS 2025 - Report date needs to be corrected for Three Intake Numbers
Category/Module: Intake
Root cause: Incorrect created date has been captured in the intake which is causing issue with the NCANS report date.
            We are unable to replicate this issue in stage-3 and will monitor it for future occurence
Fix provided:  Data fix has been done correct the created date for the intake 
Data/Code fix ticket#: CIDM-11021
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We are unable to replicate this issue in stage-3 and will monitor it for future occurence
*/

UPDATE intakesnapshot
SET jsondata = jsonb_set(jsondata,'{General,CreatedDate}','"2025-01-18T22:18:29Z"'),
updatedon = now(), 
updatedby ='CIDM-11021'
where intakenumber = 'I251013211320'
and activeflag = 1;

UPDATE intakesnapshot
SET jsondata = jsonb_set(jsondata,'{General,CreatedDate}','"2024-11-09T22:35:17Z"'),
updatedon = now(), 
updatedby ='CIDM-11021'
where intakenumber = 'I241013174203'
and activeflag = 1;

UPDATE intakesnapshot
SET jsondata = jsonb_set(jsondata,'{General,CreatedDate}','"2024-12-27T22:06:54Z"'),
updatedon = now(), 
updatedby ='CIDM-11021'
where intakenumber = 'I241013197635'
and activeflag = 1;

