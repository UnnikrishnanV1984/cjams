/*
Issue Description: Please do a data fix to change the finding from ruled out to Indicated.
Category/Module: Support
Root cause: Investigation findings in old closed cases cannot be edited
Fix provided: DB query to change the investigation finding to indicated
Data/Code fix ticket#: CDM-42651
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating investigationfinding
update investigationfinding
set investigationfindingtypekey = 'ID', updatedby = 'CDM-42651', updatedon = now()
where investigationfindingid = '9e294126-a3f5-45e4-85c4-19d6f6fc2d70' and activeflag = 1;