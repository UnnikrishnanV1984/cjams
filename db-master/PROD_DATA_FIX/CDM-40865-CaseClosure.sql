/*
Issue Description: 
1. Need to revert the IV-E Case closure review request sent to IV-E Supervisors.
2. Need to hide the "All IV-E eligibility determination has been completed" check box and Case worker should be able to send the Case closure request to Case Supervisor.
Category/Module: Bug
Root cause: Approval of IV-E eligibility determination is mandatory according to the code.
Fix provided: DB query to revert the IV-E request and mark it as complete
Data/Code fix ticket#: CDM-40865
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CDM-38413
Reason why no related code fix: Codefix not yet deployed.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating IV-E case closure review request
update ivecaseclosurereview
set activeflag = 0, updatedby = 'CDM-40865', updatedon = now()
where ivecaseclosurereviewid = '27f49d0c-aa78-4a18-acde-71f6a0fa4ee3' and activeflag = 1;

--Removing IV-E case closure review request from routing
update routing
set activeflag = 0, updatedby = 'CDM-40865', updatedon = now()
where routingid = '3bb604d4-2a33-42d0-958e-cd82610372f1' and activeflag = 1;