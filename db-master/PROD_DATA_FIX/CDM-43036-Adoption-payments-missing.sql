/*
Issue Description: CDM-43036: Adoption Subsidy missing from 08/01/2024 to 10/31/2024
Category/Module: Payments/ Adoption subsidy
Root cause: Adoption subsidy payments were missing for the client 08/01/2024 to 10/31/2024 as client was added to provided side and DOB was updated as null.
            Payments Batch validates the age based on the DOB field and since it was missing for these three months
Fix provided: Data fix has been done to update the audit columns in adoptioncaseagreementrate table and reran the adoption under over batch  
Data/Code fix ticket#: CDM-43036
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue occured due to null Date of birth fields being inserted when client was added in provider application and they will be fixing it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreementrate 
set updatedon = now(),
    updatedby = 'CDM-43036'
where adoptionagreementrateid  = '0e5abc14-6f2b-40a4-b8fa-8752db6bc155'
and activeflag=1;   
