
/* Issue Description: User requested for assessment approval from backend
Category/Module: Bug
Fix provided: DB query to approve assessment from backend
Code/Data fix ticket#: CJAMS-68728
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update:Query: set the assessment status typeid as approved
*/

update form1080a 
set status = 'Approved', submitforapproval = 'Approved',updatedby = '87b3376e-99f0-4472-8b26-8fc0b0096781', updatedon= now()
where form1080aid='7cad82c4-0af1-4257-a624-945ca99c2c2e' and activeflag = 1;

