/*
Issue Description: user wants to update the contact from attempted to completed for below contact
Category/Module: Error
Root cause: Contact shows "attempted" even though it was completed
Fix provided: DB query to change the contact to completed
Data/Code fix ticket#: CDM-43986
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update progressnote 
set contactstatus = true, updatedby = 'CDM-43986', updatedon  = now()
where progressnoteid = '43897196-1d0d-4e75-a614-9aabbc8279d8' and activeflag = 1;