
/*
Issue Description: Please 02/21/2025 and please proceed with the data fix to remove the respective document.
Category/Module: Bug
Root cause: user can able to upload docs, they can not able to delete docs
Fix provided: DB queries to deleted dcos in documentpropertiesid,documentpropertiesid tables
Data/Code fix ticket#: CJAMS-57679
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/


update documentproperties
set activeflag = 0 ,updatedby = 'CJAMS-57679', updatedon = now()
where documentpropertiesid = '673a7828-dfc9-43e4-9005-d66d0d08667f' and activeflag =1;

update documentattachment 
set activeflag = 0 ,updatedby = 'CJAMS-57679', updatedon = now()
where documentpropertiesid = '63fd2bee-d13f-4ea4-8d3a-dcd4c36989af' and activeflag = 1;
