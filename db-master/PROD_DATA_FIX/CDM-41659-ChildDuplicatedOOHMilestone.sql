/*
Issue Description: Delete - SAFE-C initiated 1/26/24, completed 1/24/24
Category/Module: Error
Root cause: Duplicate Safe-C record was created
Fix provided: DB queries to deactivate duplicate record
Data/Code fix ticket#: CDM-41659
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating record in assessment
update assessment 
set activeflag = 0, updatedby = 'CDM-41659', updatedon = now()
where assessmentid = 'd90d9e07-7ecd-4b7d-bee7-8eb3f86238cc' and activeflag = 1;

--Deactivating record in assessment_history
update assessment_history 
set activeflag = 0, updatedby = 'CDM-41659', updatedon = now()
where assessmenthistoryid = '7dcc1562-ceec-4377-8af4-d6fc9ec5572b' and activeflag = 1;

--Deactivating record in assessmentcomments
update assessmentcomments
set activeflag = 0, updatedby = 'CDM-41659', updatedon = now()
where assessmentid = 'd90d9e07-7ecd-4b7d-bee7-8eb3f86238cc' and activeflag = 1;

--Deactivating record in assessmentactor
update assessmentactor
set activeflag = 0, updatedby = 'CDM-41659', updatedon = now()
where assessmentid = 'd90d9e07-7ecd-4b7d-bee7-8eb3f86238cc' and activeflag = 1;

--Deactivating record in routing
update routing
set activeflag = 0, updatedby = 'CDM-41659', updatedon = now()
where routingid = '48d72beb-ee47-4d87-9168-bc38fce37760' and activeflag = 1;