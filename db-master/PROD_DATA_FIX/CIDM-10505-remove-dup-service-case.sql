/*
Issue Description: datafix for the duplication of the servicecase
Category/Module: Support
Root cause: System error, validation missing
Fix provided: DB query end date the service log
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CDM-44378
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservicerequest
set updatedby = 'CIDM-10505',
	actiontype = null,
	updatedon = now(),
	activeflag =0
where intakeserviceid in ('85c64235-4d12-4ff9-8732-6ebd112a959c',
'570f16d7-7aeb-41c7-a965-9242be5cf83b')
	and activeflag =1 and intakenumber = 'I251013274340';