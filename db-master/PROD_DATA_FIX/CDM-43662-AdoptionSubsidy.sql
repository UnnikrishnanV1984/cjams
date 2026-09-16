/*
Issue Description: Worker entered the subsidy rate incorrectly and need data fix to update below highlighted begin date
Category/Module: User Error
Root cause: Data in old subsidy rate agreements cannot be modified
Fix provided: DB query to change the start date of subsidy rate agreements 
Data/Code fix ticket#: CDM-43662
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--updating adoptioncaseagreementrate
update adoptioncaseagreementrate
set startdate = '2025-01-15 01:00:00.000', updatedby = 'CDM-43662', updatedon = now()
where adoptionagreementrateid = 'f4f41e91-d7b6-4cef-bcf9-d6e673df1ddd' and activeflag = 1;

update adoptioncaseagreementrate
set startdate = '2024-01-15 01:00:00.000', updatedby = 'CDM-43662', updatedon = now()
where adoptionagreementrateid = 'c185d043-f32f-4ea9-8d69-9f609dbeffe2' and activeflag = 1;

--updating adoptioncaserevision
update adoptioncaserevision
set startdate = '2025-01-15 01:00:00.000', updatedby = 'CDM-43662', updatedon = now()
where adoptionagreementrateid = 'f4f41e91-d7b6-4cef-bcf9-d6e673df1ddd' and activeflag = 1;

update adoptioncaserevision
set startdate = '2024-01-15 01:00:00.000', updatedby = 'CDM-43662', updatedon = now()
where adoptionagreementrateid = 'c185d043-f32f-4ea9-8d69-9f609dbeffe2' and activeflag = 1;