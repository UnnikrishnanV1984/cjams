/*
Issue Description: SSA approved on 10/07/2024 to reopen the CPS AR case as requested.
Category/Module: Support
Root cause: Case needs to be reopened because the family has recently been located
Fix provided: DB queries to reopen the case
Data/Code fix ticket#: CDM-41772
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservicerequest
update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CDM-41772', updatedon = now()
where intakeserviceid = 'b82bb203-dc44-4011-9c04-80c2ddd15ba1' and activeflag = 1;

--Updating intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CDM-41772', updatedon = now()
where intakeservicerequestdispositioncodeid = '1d33bdd6-d391-4a3f-92dd-c1c7b55e8c33' and activeflag = 1;

--Updating routing
update routing 
set activeflag = 0, updatedby = 'CDM-41772', updatedon = now()
where routingid = 'e1b3a040-d889-479b-a6ca-50e9b1b423d8' and activeflag = 1;

--Updating caseassignment
update caseassignment
set enddate = null, updatedby = 'CDM-41772', updatedon = now()
where caseassignmentid = 'd7996605-d483-4a31-b7e5-7ff97fec5bec' and activeflag = 1;