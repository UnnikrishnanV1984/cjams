/*
Issue Description:CJAMS-60520  Intake referral generated in error
Category/Module: Intake 
Root cause: intake I241012801921, intake referral was generated in error
Data/Code fix ticket#: CJAMS-60520
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakedastaging
set activeflag=0, updatedby='CJAMS-60520', updatedon=now()
where intakenumber='I241012801921' and activeflag=1;

update intakedastatus
set activeflag=0, updatedby='CJAMS-60520', updatedon=now()
where intakenumber='I221010323970' and activeflag=1;