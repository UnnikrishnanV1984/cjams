/*
Issue Description: please deactivate margaret.oni@montgomerycountymd.gov in cjams db
Category/Module: Support
Root cause: Worker's old email wasn't deactivated, causing her name to appear twice
Fix provided: DB queries to deactivate the duplicate user accout
Data/Code fix ticket#: CDM-42974
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating userprofile
update userprofile
set activeflag = 0, updatedby = 'CDM-42974', updatedon = now()
where securityusersid = 'ba6b308d-4520-4883-b29c-794ae982d2d7' and activeflag = 1;

--Deactivating teammember
update teammember
set activeflag = 0, updatedby = 'CDM-42974', updatedon = now()
where teammemberid = '809069f2-6967-4987-8ffc-cf62c5bc31f0' and activeflag = 1;

--Deactivating teammemberassignment
update teammemberassignment
set activeflag = 0, updatedby = 'CDM-42974', updatedon = now()
where teammemberassignmentid = '809069f2-6967-4987-8ffc-cf62c5bc31f0' and activeflag = 1;

--Deactivating muser
update muser
set activeflag = 0, updatedby = 'CDM-42974', updatedon = now()
where email = 'margaret.oni@montgomerycountymd.gov' and activeflag = 1;

--Deactivating rolemapping
update rolemapping
set activeflag = 0, updatedby = 'CDM-42974', updatedon = now()
where principalid = '14416' and activeflag = 1;

--Deactivating securityusers
update securityusers
set activeflag = 0, updatedby = 'CDM-42974', updatedon = now()
where securityusersid = 'ba6b308d-4520-4883-b29c-794ae982d2d7' and activeflag = 1;

--Deactivating caseassignment
update caseassignment
set activeflag = 0, updatedby = 'CDM-42974', updatedon = now()
where activeflag = 1 and caseassignmentid in (
'9dc7376c-2c13-4659-bb55-610acd72e0a6',
'98f882f3-6bac-4e4f-8722-df88c14c97f3',
'b669381d-71f0-46ec-86e9-5401ff9e4ad9',
'5911ccac-af98-4b77-b6d8-af5c8086dfc8');