/*
User wants to change the start date from 06/07/2024 to 08/23/2023 for the following school.
School Name: Spring Ridge Elementary
Current Grade: Grade 3   
PID: 4111119 
Case Number : 3241584
Category/Module: Support
Root cause: Only school end date can be edited after record is created
Fix provided: DB query to change the start date
Data/Code fix ticket#: CDM-42230
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support request
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating personeducation_history
update personeducation_history
set startdate = '2023-08-23 00:00:00.000', updatedby = 'CDM-42230', updatedon = now()
where personeducationhistoryid = '3770c5fa-6b6a-4f6c-9ac1-268a8219826f' and activeflag = 1;