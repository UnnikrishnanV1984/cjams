/*
Issue Description: Please update the phone number as requested by the user in cjams db. Workphonenumber is already updated in sailpoint
Category/Module: Error
Root cause: User's personal number was added instead of work number
Fix provided: DB query to update cell number for the user
Data/Code fix ticket#: CDM-41933
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating userprofilephonenumber
update userprofilephonenumber
set phonenumber = '4103714730', updatedby = 'CDM-41933', updatedon = now()
where userprofilephonenumberid = '239b5408-5244-43b3-9afd-1f5a05be3633' and activeflag = 1;