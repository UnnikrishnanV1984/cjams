
/*
Issue Description: Please 02/21/2025 and please proceed with the data fix to remove the respective document.
Category/Module: Bug
Root cause: user can able to upload docs, they can not able to delete docs
Fix provided: DB queries to deleted dcos in documentpropertiesid,documentpropertiesid tables
Data/Code fix ticket#: CJAMS-57678
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/


update documentproperties
set activeflag = 0 ,updatedby = 'CJAMS-57678', updatedon = now()
where documentpropertiesid in (
'b2c592d4-57fd-454c-921b-2bd2fc122e08','9cd964a1-3905-446d-bc6a-b364bddd7858') and activeflag =1;

update documentattachment 
set activeflag = 0 ,updatedby = 'CJAMS-57678', updatedon = now()
where documentpropertiesid in ('ddfcb4c3-50ef-4b15-8057-5233b84faf0a','8376c610-ebec-44cb-a05c-2c1f61fcab8b') and activeflag = 1;
