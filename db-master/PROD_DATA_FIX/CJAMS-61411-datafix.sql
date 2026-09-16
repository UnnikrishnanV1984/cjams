/*
Issue: Intake # CW9945548 is still available in the intake worker (TESSA TRIM) Pending dashboard.
Category/Module: Bug
Root cause: User requested to remove CW2898321 is still available in the intake worker (TESSA TRIM) Pending dashboard.
Fix provided: Data fix has been done to remove CW2898321 is still available in the intake worker (TESSA TRIM) Pending dashboard.
Data/Code fix ticket#: CJAMS-61411
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE cjams.intakedastatus
SET status=2, updatedby='CJAMS-61411', updatedon=now()
WHERE intakenumber='CW9945548';

UPDATE cjams.intakedastaging
SET status='Complete', updatedby='CJAMS-61411', updatedon=now(), activeflag = 0
WHERE intakenumber='CW9945548' and activeflag = 1;