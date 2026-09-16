/*
Issue Description: Need analysis on why the program assignment is not end dated and also do a data fix to end date the CPS AR program assignment for all the clients in the case with 6/6/2023.
Category/Module: Error
Root cause: Old program assignments seem to not end when case is completed
Fix provided: DB query to end program assignments for all clients
Data/Code fix ticket#: CDM-41495
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update personprogramarea
set enddate = '2023-06-06 00:00:00', updatedby = 'CDM-41495', updatedon = now()
where 
	activeflag = 1 and 
	personprogramid in (
	'51b12562-ae99-47c8-a2b4-36368dcbc8b8',
	'884764a6-5747-4f76-b234-362dbfa63b92',
	'f38a6fc2-df65-46ec-a932-45408fbc8ece',
	'05f541a7-97e3-4df9-a35c-c1705949075d');