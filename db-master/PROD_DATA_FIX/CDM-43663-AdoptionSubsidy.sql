/*
Issue Description: Worker entered the subsidy rate incorrectly and need data fix to update below highlighted begin date
Category/Module: User Error
Root cause: Data in old subsidy rate agreements cannot be modified
Fix provided: DB query to change the start date of subsidy rate agreements 
Data/Code fix ticket#: CDM-43663
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
where adoptionagreementrateid = '3baf8d2c-5e2c-41f3-ad49-d189ca86887b' and activeflag = 1;

update adoptioncaseagreementrate
set startdate = '2024-01-15 01:00:00.000', updatedby = 'CDM-43662', updatedon = now()
where adoptionagreementrateid = '7965f12a-35a7-4d67-b0c5-e04e41c5cfcc' and activeflag = 1;

--updating adoptioncaserevision
update adoptioncaserevision
set startdate = '2025-01-15 01:00:00.000', updatedby = 'CDM-43662', updatedon = now()
where adoptionagreementrateid = '3baf8d2c-5e2c-41f3-ad49-d189ca86887b' and activeflag = 1;

update adoptioncaserevision
set startdate = '2024-01-15 01:00:00.000', updatedby = 'CDM-43662', updatedon = now()
where adoptionagreementrateid = '7965f12a-35a7-4d67-b0c5-e04e41c5cfcc' and activeflag = 1;