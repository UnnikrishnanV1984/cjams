/*
Issue Description: Please proceed with the data fix to update the worker cell phone number to (443) 924-1892
Category/Module: Bug
Root cause: user could not abe to change phonenumber, they can only add number
Fix provided: DB queries update the number in worker with userprofilephonenumber
Data/Code fix ticket#:CJAMS-58373
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/






update userprofilephonenumber 
set phonenumber = '443-924-1892',
	updatedby = 'CJAMS-58373',
	updatedon = now()
where userprofilephonenumberid = '3807c322-2223-4ffd-b110-f3c653cfbcc2'
and activeflag = 1;