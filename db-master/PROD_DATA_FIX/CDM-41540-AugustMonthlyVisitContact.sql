/*
Issue Description: user wants to update the contact from attempted to completed for below contact
Contact ID: 14290267
Contact Date: 08/16/2024
Entered Date: 08/20/2024
Category/Module: Error
Root cause: Contact dated 8/15 shows "attempted" even though it was completed
Fix provided: DB query to change the contact to completed
Data/Code fix ticket#: CDM-41540
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating contact in progressnote
update progressnote 
set contactstatus = true, updatedby = 'CDM-41540', updatedon  = now()
where progressnoteid = '02b40183-fb3d-4fba-ba86-d517343f04c1' and activeflag = 1;