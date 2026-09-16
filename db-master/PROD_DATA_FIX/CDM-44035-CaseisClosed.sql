/*
Issue Description: We are unable to close the administrative rights on our end
Category/Module: Support
Root cause: Case Assignments cannot be end-dated after closing the case
Fix provided: DB query to end the active case assignment for this case
Data/Code fix ticket#: CDM-44035
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating caseassignment
update caseassignment
set enddate = '2024-12-23 11:17:37.194', updatedby = 'CDM-44035', updatedon = now()
where caseassignmentid = '1bdaf4f0-fb87-4ccb-a7c4-d18c2249f66e' and activeflag = 1;