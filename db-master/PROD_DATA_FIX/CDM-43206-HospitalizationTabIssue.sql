/*
Issue Description: Had a call with worker and the following two hospitalization records should be deleted.
Category/Module: User Error
Root cause: Users cannot edit or delete hospitalization records with activeflag 2
Fix provided: DB queries to deactivate duplicate hospitalization records
Data/Code fix ticket#: CDM-43206
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in personhospitalization
update personhospitalization
set activeflag = 0, updatedby = 'CDM-43206', updatedon = now()
where hospitalizationid in ('723502b2-0874-482f-b722-653d9cbf5c8f', '46c50d9f-5b55-41a7-8602-91e53338a8db') and activeflag = 2;

--Deactivating in personhospitalization_history
update personhospitalization_history
set activeflag = 0, updatedby = 'CDM-43206', updatedon = now()
where hospitalizationid in ('723502b2-0874-482f-b722-653d9cbf5c8f', '46c50d9f-5b55-41a7-8602-91e53338a8db') and activeflag = 2;