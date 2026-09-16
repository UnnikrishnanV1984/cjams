/*
Issue Description: Need data fix for Administration as Family and start date as 08/07/2024
Category/Module: Support
Root cause: User needs this datafix to fix a duplicate record in SEN milestone report
Fix provided: DB query to change the Case Assignment record
Data/Code fix ticket#: CDM-42633
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating caseassignment
update caseassignment
set responsibilitytypekey = 'family', startdate = '2024-08-07 00:00:00', updatedby = 'CDM-42633', updatedon = now()
where caseassignmentid = '0e1ce1fb-b741-4bd3-b232-c05452f11419' and activeflag = 1;