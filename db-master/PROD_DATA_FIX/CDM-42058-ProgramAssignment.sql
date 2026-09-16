/*
Issue Description (Updated): The Case is Closed in Production, so need to end date the CPS program assignment with "10/25/2024" (case closure date) for Client ID: 1996548 and update the name as "Lindsey Sears".  
Category/Module: Bug
Root cause: Case was ended before datafix was patched, so new datafix requred
Fix provided: DB query to end pending program assignment for this closed case
Data/Code fix ticket#: CDM-42058
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating personprogramarea
update personprogramarea
set enddate = '2024-10-25 00:00:00', updatedby = '7d13a2ae-7956-400f-9ff0-143123ce7b2c', updatedon = now()
where personprogramid = '27959974-afea-4388-a5ce-3b3132d81f65' and activeflag = 1;