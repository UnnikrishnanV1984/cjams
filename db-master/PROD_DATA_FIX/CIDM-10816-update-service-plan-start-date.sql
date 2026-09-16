/*
Issue Description:CIDM-10816 Service Plan Start Date
Category/Module: Service Plan
Root cause: Service Plan effective date got updated while updating the end date and code fix ticket is created to resolve it.
            Data fix needs to be done to update the Service Plan Start date/Effective date from 02/27/2025 to "02/26/2025"
Fix provided: Data fix has been done  to update the Service Plan Start date/Effective date from 02/27/2025 to "02/26/2025"
Data/Code fix ticket#:CIDM-10816
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#: CDM-44525
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update serviceplan
set effectivedate = '2025-02-26 00:00:00',
    updatedon = now(),
    updatedby = 'CIDM-10816'
where serviceplanid='23056bc5-9654-450a-b586-0e7a41b3897b'
and activeflag = 1;    
