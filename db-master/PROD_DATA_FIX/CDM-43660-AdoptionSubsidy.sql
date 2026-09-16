/*
Issue Description: Worker entered the subsidy rate incorrectly and need data fix to update below highlighted begin date
Category/Module: User Error
Root cause: Data in old subsidy rate agreements cannot be modified
Fix provided: DB queries to change the start date of subsidy rate agreements 
Data/Code fix ticket#: CDM-43660
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--updating adoptioncaseagreementrate
update adoptioncaseagreementrate
set startdate = '2025-01-15 05:00:00.000', updatedby = 'CDM-43660', updatedon = now()
where adoptionagreementrateid = '72dd94aa-4ef8-422e-b801-5d5b180d0e21' and activeflag = 1;

update adoptioncaseagreementrate
set startdate = '2024-01-15 01:00:00.000', updatedby = 'CDM-43660', updatedon = now()
where adoptionagreementrateid = '8fe3d7bc-54eb-412a-81b7-82249df94bee' and activeflag = 1;

--updating adoptioncaserevision
update adoptioncaserevision
set startdate = '2025-01-15 05:00:00.000', updatedby = 'CDM-43660', updatedon = now()
where adoptionagreementrateid = '72dd94aa-4ef8-422e-b801-5d5b180d0e21' and activeflag = 1;

update adoptioncaserevision
set startdate = '2025-01-15 01:00:00.000', updatedby = 'CDM-43660', updatedon = now()
where adoptionagreementrateid = '8fe3d7bc-54eb-412a-81b7-82249df94bee' and activeflag = 1;