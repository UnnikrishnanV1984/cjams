/*
Issue Description:The record in incomplete ( 01/31/2026 01/30/2027) need to be deleted as data fix.
Root cause: User request to delete the incomplete Subsidy rate, due to they do not have access to do that.
Fix provided: DB queries  update enddate adoptioncaserevision tables
Data/Code fix ticket#: CJAMS-60961
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update adoptioncaserevision
set activeflag = 0, updatedby  = 'CJAMS-60961' ,updatedon  =  now()
where adoptionrevisionid = '9e03af8c-7554-4e0e-90eb-61d7ff6ebb80' and activeflag =1;
