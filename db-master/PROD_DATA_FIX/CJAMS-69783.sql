/*
Issue Description: CJAMS-69783
Category/Module: JCR Reconciliation (Legislative Required Reporting)
Root cause: Incorrect reason was selected in the Legislative Required Reporting Window due to a supervisor delay.
Fix provided: Update the reason to “Case not assigned timely > Supervisor delays.
Is code fix required : N
Reason why no related code fix: User error
Regression impacts: NA
*/


update cpsresponsetimeractions
set cpsresponsetimerreason1='VCNT',
	cpsresponsetimerreason2='VSDT',
	updatedby='CJAMS-69783',
	updatedon=now()
where cpsresponsetimeractionsid='f64d6e20-62dc-4f59-8c88-0fddda43d213' and activeflag=1;