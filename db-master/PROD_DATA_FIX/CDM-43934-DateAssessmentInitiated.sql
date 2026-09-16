/*
Issue Description: Need data fix to add the Date Assessment Initiated with 10/22/2024 for below SAFE OHP assessment.
Category/Module: User Error
Root cause: User did not enter an date initiated, causing the application to auto-populate it
Fix provided: DB query to enter the set date for the assessment
Data/Code fix ticket#: CDM-43934
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating assessment
update assessment
set submissiondata = jsonb_set(submissiondata::jsonb, '{dateassessmentinitiated}', '"2024-10-22T09:00:00.000Z"', true),
	updatedby = 'CDM-43934', updatedon = now()
where assessmentid = '900feee4-dd2b-4abf-9b09-9adf4ee32abd' and activeflag = 1;