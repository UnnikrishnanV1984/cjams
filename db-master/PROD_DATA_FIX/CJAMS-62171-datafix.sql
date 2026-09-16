/*
Issue Description: CJAMS-62171 User requested to update the LRR reason as "Alleged victim unavailable > 
Family contacted but unable to meet within mandate"
Category/Module: Overdue Reason
Root cause: User requested to update the LRR reason as "Alleged victim unavailable > 
Family contacted but unable to meet within mandate"
Fix provided: Data fix has been doneto update the LRR reason as "Alleged victim unavailable > 
Family contacted but unable to meet within mandate"
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

UPDATE cpsresponsetimeractions
SET cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VFCM',
    updatedon = now(),
    updatedby = 'CJAMS-62171'
WHERE cpsresponsetimeractionsid = '467068c6-5233-4960-a21b-b47ea911b749'
  AND intakeserviceid = 'a3e94e03-b627-4499-a11e-f1bfe009af6a'
  AND activeflag = 1;