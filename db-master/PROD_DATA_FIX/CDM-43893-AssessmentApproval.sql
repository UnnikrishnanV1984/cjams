/*
Issue Description: Need data fix to remove the Home Health Assessment from the supervisor approval inbox.
Category/Module: Support
Root cause: Case was changed to AR so this Home Health Assessment is not required
Fix provided: DB query to remove the Home Health Assessment from supervisor inbox
Data/Code fix ticket#: CDM-43893
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating routing
update routing
set activeflag = 0, updatedby = 'CDM-43893', updatedon = now()
where routingid = 'bb1a5a47-9704-422a-a367-f388066a27d9' and activeflag = 1;