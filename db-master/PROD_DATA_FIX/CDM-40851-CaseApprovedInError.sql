/*
Issue Description: Need data fix to re-open the CPS-IR 241022192275 case
Category/Module: Error
Root cause: The case was approved for closure in error
Fix provided: DB query to reopen the case
Code/Data fix ticket#: CDM-40851
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error 
Backup before update/ delete:Query:
*/

--Reopening the case in intakeservicerequest
update intakeservicerequest
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CDM-40851', updatedon = now()
where intakeserviceid = 'd5867326-c45c-4f93-bc05-ee57d049576a' and activeflag = 1;

--Reverting decision tab to review in intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CDM-40851', updatedon = now()
where intakeservicerequestdispositioncodeid in (
'2b7322db-6230-4228-a5d6-68304f69ff9b',
'b8a5ca52-1642-4df7-b9a3-c669ce45ffcb',
'f6801a97-026b-495a-a613-ae991e295ee6') and activeflag = 1;

--Reverting decision in routing
update routing
set activeflag = 0, updatedby = 'CDM-40851', updatedon = now()
where routingid = '0edc1f47-ebd5-466e-aabb-b700e969c5bc' and activeflag = 1;