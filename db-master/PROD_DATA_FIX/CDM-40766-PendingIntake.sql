/*
Issue Description: Please remove the intake from the user pending dashboard and need root cause analysis on this matter.
Category/Module: Bug
Root cause: Old removed intake persisted on the Pending Intake list of the user.
Fix provided: Db query to remove the intake from Pending list.
Code fix ticket#: CDM-40766
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Database issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Update case to complete in intakestaging
update intakedastaging 
set status = 'Complete', updatedby = 'CDM-40766', updatedon = now()
where intakenumber = 'I211010188493' and activeflag = 1;