/*
Issue Description: Had a call with worker, need a data fix to remove the old hospitalization record for the below.
Category/Module: User Error
Root cause: Users cannot edit or delete hospitalization records with activeflag 2
Fix provided: DB queries to deactivate duplicate hospitalization record
Data/Code fix ticket#: CDM-43352
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
where hospitalizationid = 'f8f7121e-9dc6-4d4a-8665-a77ad8ca1c27' and activeflag = 2;

--Deactivating in personhospitalization_history
update personhospitalization_history
set activeflag = 0, updatedby = 'CDM-43206', updatedon = now()
where personhospitalizationhistoryid = '06d94f32-4ec1-4b72-9c5a-ac23cf24f795' and activeflag = 2;