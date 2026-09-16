/*
Issue Description:User requested to reopen the case
Category/Module: Support
Root cause: Case needs to be reopened as it was closed in error
Fix provided: DB queries to reopen the case
Data/Code fix ticket#: Cjams-57869
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservicerequest
update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CJAMS-57869', updatedon = now()
where intakeserviceid = '4646eb7b-4e3b-40de-9027-2b8a2b699ae9' and activeflag = 1;

--Updating intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CJAMS-57869', updatedon = now()
where intakeservicerequestdispositioncodeid = '55ad4b73-7b2c-4ce5-8482-00729936127d' and activeflag = 1;

--Updating routing
update routing 
set activeflag = 0, updatedby = 'CJAMS-57869', updatedon = now()
where routingid = '4646eb7b-4e3b-40de-9027-2b8a2b699ae9' and activeflag = 1;

--Updating caseassignment
update caseassignment
set enddate = null, updatedby = 'CJAMS-57869', updatedon = now()
where caseassignmentid = 'e403ff8f-5a1f-43b0-9ea6-b8c2823fbfe2' and activeflag = 1;