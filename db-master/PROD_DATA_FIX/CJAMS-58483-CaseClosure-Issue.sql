/*
Issue Description: Adoption case is closed on 07/09/2024 and the worker assignment is still open.
Please do a data fix to ended both workers assignment with 07/09/2024
Category/Module: Bug
Root cause: due to data gltich casued to date is updated , user do not have access to do that
Fix provided: DB queries  update enddate caseassignment tables
Data/Code fix ticket#: CJAMS-58483
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update caseassignment 
set enddate = '2024-07-09', updatedby = 'CJAMS-58483', updatedon = now()
where caseassignmentid in ( 'b0023ddb-9293-42dd-bebd-f119431e1a8b','6fdcebfa-0dc7-4196-aebd-7f47e568a559')  and activeflag =1;